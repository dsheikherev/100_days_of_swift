//
//  ViewController.swift
//  Project4
//
//  Created by Denis Sheikherev on 01.03.2020.
//  Copyright © 2020 Denis Sheikherev. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var progressView: UIProgressView!
    
    var websites = ["apple.com", "mainconcept.com"]
    
    var goBack: UIBarButtonItem?
    var goForward: UIBarButtonItem?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        goBack = UIBarButtonItem(title: "Back", style: .plain, target: webView, action: #selector(webView.goBack))
        goForward = UIBarButtonItem(title: "Forward", style: .plain, target: webView, action: #selector(webView.goForward))
        
        let progressButton = UIBarButtonItem(customView: progressView)

        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    
        if webView.backForwardList.forwardList.count > 0 {
            if !(toolbarItems!.contains(goForward!)) {
                var i = 0
                if (toolbarItems!.contains(goBack!)) {
                    i += 1
                }
                toolbarItems!.insert(goForward!, at: i)
            }
        } else {
            if (toolbarItems!.contains(goForward!)) {
                let i = toolbarItems!.firstIndex(of: goForward!)!
                toolbarItems!.remove(at: i)
            }
        }
        
        if webView.backForwardList.backList.count > 0 {
            if !(toolbarItems!.contains(goBack!)) {
                toolbarItems?.insert(goBack!, at: 0)
            }
        } else {
            if (toolbarItems!.contains(goBack!)) {
                let i = toolbarItems!.firstIndex(of: goBack!)!
                toolbarItems!.remove(at: i)
            }
        }

    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
//        let ac = UIAlertController(title: "Forbidden", message: "It's blocked web-site", preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            decisionHandler(.cancel)
//        }))
//        present(ac, animated: true)
    }
}

