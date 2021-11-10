//
//  ViewController.swift
//  Project2
//
//  Created by PEDRO HENRIQUE CALADO on 11/9/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries: [String] = []
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0
    var maxNumberOfQUestions = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "See score", style: .plain, target: self, action: #selector(didSeeScoreTapped))
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderWidth = 2
        button2.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor // uma alternativa
        button3.layer.borderWidth = 3
        button3.layer.borderColor = UIColor.lightGray.cgColor
        askQuestion()
    }
    
    @objc func didSeeScoreTapped() {
        let ac = UIAlertController(title: "Keep it going", message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Let's play", style: .default, handler: nil))
        
        present(ac, animated: true)
    }
    
    func askQuestion(_ alert: UIAlertAction! = nil) {
//        button1.setBackgroundImage(UIImage.init(named: countries.randomElement()!), for: .normal)
//        button2.setBackgroundImage(UIImage.init(named: countries.randomElement()!), for: .normal)
//        button3.setBackgroundImage(UIImage.init(named: countries.randomElement()!), for: .normal)
        
        if questionsAsked == 10 {
            score = 0
            questionsAsked = 0
        }
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setBackgroundImage(UIImage.init(named: countries[0]), for: .normal)
        button2.setBackgroundImage(UIImage.init(named: countries[1]), for: .normal)
        button3.setBackgroundImage(UIImage.init(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()), YOUR SCORE IS \(score)"
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        questionsAsked += 1
        var title: String
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        
        if questionsAsked == 10 {
            let ac = UIAlertController(title: title, message: "Your final score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Play again", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
        } else {
            let ac = title == "Correct" ?
            UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert) :
            UIAlertController(title: title, message: "That's the flag of \(countries[sender.tag].uppercased()). Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
        }
    }
        


}

