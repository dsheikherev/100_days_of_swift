//
//  ViewController.swift
//  Project2
//
//  Created by Denis Sheikherev on 22.02.2020.
//  Copyright © 2020 Denis Sheikherev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries: [String] = []
    var correctAnswer = 0
    var score = 0
    var totalAnsweredQs = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = "\(countries[correctAnswer].uppercased()) (Score: \(score))"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var message: String
        var buttonText: String
        
        if sender.tag == correctAnswer {
            score += 1
            title = "Correct"
            message = "Your score is \(score)"
        } else {
            score = (score - 1 >= 0) ? score - 1: 0
            title = "Wrong"
            message = "That's \(countries[sender.tag].uppercased()). Your score is \(score)"
        }

        totalAnsweredQs += 1
                
        if totalAnsweredQs == 10 {
            title = "Game Over!"
            message = "Your final score is \(score)"
            buttonText = "Restart"
            totalAnsweredQs = 0
            score = 0
        } else {
            buttonText = "Continue"
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: buttonText, style: .default, handler: askQuestion))
        present(ac, animated: true)
        
    }
    
    @objc func shareTapped() {
        let message = "Your score is \(score)"
        
        let vc = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}

