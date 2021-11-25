//
//  ViewController.swift
//  Project5
//
//  Created by PEDRO HENRIQUE CALADO on 11/11/21.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    var errorTitle: String?
    var errorMessage: String?
    var dataToSave: [String: [String]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGameWithNewWord))
        
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsUrl) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        UserDefaults.standard.register(defaults: ["words": ""])

        startGame()
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        
        let lowerAnswer = answer.lowercased()
        
        if isNotStartWord(word: lowerAnswer) {
            if isNotShort(word: lowerAnswer) {
                if isPossible(word: lowerAnswer) {
                    if isOriginal(word: lowerAnswer) {
                        if isReal(word: lowerAnswer) {
                            usedWords.insert(lowerAnswer, at: 0)
                            save()
                            let indexPath = IndexPath(row: 0, section: 0)
                            tableView.insertRows(at: [indexPath], with: .automatic)
                            return
                        } else {
                            showErrorMessage(title: "Word not recognized", message: "You can't just make them up, you know")
                        }
                    } else {
                        showErrorMessage(title: "Word already used", message: "Be more original")
                    }
                } else {
                    guard let title = title else { return }
                    showErrorMessage(title: "Word not possible", message: "You can't speel that word from \(title.lowercased()).")
                }
            } else {
                showErrorMessage(title: "Word is too short", message: "Write a word longer than 2 characters")
            }
        } else {
            showErrorMessage(title: "Word is equal to start word", message: "Provide a word diffrent from the start word")
        }
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    func showErrorMessage(title: String, message: String) {
        errorTitle = title
        errorMessage = message
    }
    
    func isNotShort(word: String) -> Bool {
        return word.count > 2
    }
    
    func isNotStartWord(word: String) -> Bool {
        return word != title
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = usedWords[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    @objc func startGameWithNewWord() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    func startGame() {
        let savedWord = getUsedWords()?.keys.first
        usedWords = getUsedWords()?.values.first ?? []
        title = savedWord == nil ? allWords.randomElement() : savedWord
        tableView.reloadData()
    }
    
    func save() {
        dataToSave = [title ?? "": usedWords]
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(dataToSave) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "words")
        } else {
            print("Failed to save words.")
        }
    }
    
    func getUsedWords() -> [String: [String]]? {
        let jsonDecoder = JSONDecoder()
        let defaults = UserDefaults.standard
        var data: [String: [String]] = [:]
        
        if let savedWords = defaults.object(forKey: "words") as? Data {
            do {
                data = try jsonDecoder.decode([String: [String]].self, from: savedWords)
            } catch {
                print("Failed to load words.")
            }
        }
        return data
    }
}

