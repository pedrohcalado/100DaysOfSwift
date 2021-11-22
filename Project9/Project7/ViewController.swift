//
//  ViewController.swift
//  Project7
//
//  Created by PEDRO HENRIQUE CALADO on 11/16/21.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    var urlString: String?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search petitions"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(creditsTapped))
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    @objc func fetchJSON() {
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            //            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=1000&limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        //        let urlString = "https://pokeapi.co/api/v2/ability/?limit=20&offset=20"
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    parse(json: data)
                    return
                }
            }
            
        }
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredPetitions = petitions.filter { (petition: Petition) -> Bool in
            return petition.title.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "there was an error", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    @objc func creditsTapped() {
        guard let url = urlString else {
            return
        }
        
        let ac = UIAlertController(title: "Credits", message: "\(url)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true, completion: nil)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredPetitions.count
        }
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let petition: Petition
        
        if isFiltering {
            petition = filteredPetitions[indexPath.row]
        } else {
            petition = petitions[indexPath.row]
        }
        
        content.text = petition.title
        content.secondaryText = petition.body
        
        content.secondaryTextProperties.numberOfLines = 2
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        if isFiltering {
            vc.detailItem = filteredPetitions[indexPath.row]
        } else {
            vc.detailItem = petitions[indexPath.row]
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}


