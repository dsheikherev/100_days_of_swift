//
//  DetailViewController.swift
//  Consolidation2
//
//  Created by Denis Sheikherev on 29.02.2020.
//  Copyright © 2020 Denis Sheikherev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var flagImage: UIImageView!
    
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let imageToLoad = selectedImage {
            flagImage.image = UIImage(named: imageToLoad)
            title = imageToLoad.replacingOccurrences(of: "@3x.png", with: "").uppercased()
        }
        
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    @objc func shareTapped() {
        guard let image = flagImage.image?.jpegData(compressionQuality: 1.0) else {
            return
        }
        
        let shareVc = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        shareVc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(shareVc, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
