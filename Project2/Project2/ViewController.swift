//
//  ViewController.swift
//  Project2
//
//  Created by PEDRO HENRIQUE CALADO on 11/9/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var questionsLabel: UILabel!
    @IBOutlet var questionsProgressView: UIProgressView!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries: [String] = []
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0
    var maxNumberOfQuestions = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "See highest score", style: .plain, target: self, action: #selector(seeScoreTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetTapped))
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderWidth = 1
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderWidth = 1
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        saveScore()
        askQuestion()
    }
    
    @objc func seeScoreTapped() {
        let ac = UIAlertController(title: "Keep it going", message: "Your highest score is \(getScore() ?? 0)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Let's play", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    @objc func resetTapped() {
        score = 0
        questionsAsked = 0
        askQuestion()
    }
    
    func askQuestion(_ alert: UIAlertAction! = nil) {
        guard let highestScore = getScore() else { return }
        if questionsAsked == maxNumberOfQuestions {
            if highestScore < score {
                saveScore()
            }
            score = 0
            questionsAsked = 0
        }
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setBackgroundImage(UIImage.init(named: countries[0]), for: .normal)
        button2.setBackgroundImage(UIImage.init(named: countries[1]), for: .normal)
        button3.setBackgroundImage(UIImage.init(named: countries[2]), for: .normal)
        title = "\(countries[correctAnswer].uppercased()) | SCORE: \(score)"
        questionsLabel.text = "Question \(questionsAsked + 1) of \(maxNumberOfQuestions)"
        questionsProgressView.setProgress(Float(questionsAsked + 1) / Float(maxNumberOfQuestions), animated: true)
    }
    
    func getScore() -> Int? {
        let defaults = UserDefaults.standard
        var highestScore: Int?
        if let savedScore = defaults.object(forKey: "highestScore") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                highestScore = try jsonDecoder.decode(Int.self, from: savedScore)
            } catch {
                print("Failed to load people.")
            }
        }
        return highestScore
    }
    
    func saveScore() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(score) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "highestScore")
        } else {
            print("Failed to save score.")
        }
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
        
        guard let highestScore = getScore() else { return }
        
        if questionsAsked == maxNumberOfQuestions {
            let ac = highestScore < score ?
                UIAlertController(title: title, message: "Your final score is \(score), which is your new highest score, it was \(highestScore) before", preferredStyle: .alert) :
                UIAlertController(title: title, message: "Your final score is \(score)", preferredStyle: .alert)
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
