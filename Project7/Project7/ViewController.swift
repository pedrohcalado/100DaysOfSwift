//
//  ViewController.swift
//  Project7
//
//  Created by PEDRO HENRIQUE CALADO on 11/16/21.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        let urlString = "https://pokeapi.co/api/v2/ability/?limit=20&offset=20"
        
        if let url = URL(string: urlString) {
//            print(url)
            if let data = try? Data(contentsOf: url) {
                print(data)
                parse(json: data)
            }
        }
        
    }
    
    
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
//            print(jsonPetitions)
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let petition = petitions[indexPath.row]
        content.text = petition.title
        content.secondaryText = petition.body
        
        cell.contentConfiguration = content
        
        
        return cell
    }
    
}

