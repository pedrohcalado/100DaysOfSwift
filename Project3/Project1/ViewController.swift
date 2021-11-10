//
//  ViewController.swift
//  Project1
//
//  Created by PEDRO HENRIQUE CALADO on 11/8/21.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item.self)
            }
        }
        pictures.sort()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        //        cell.text = pictures[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.textProperties.color = UIColor.systemPink
        content.text = pictures[indexPath.row]
        content.textProperties.font = UIFont.systemFont(ofSize: 35)
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.images = pictures
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        pictures.sort()
    }
    
    
}

extension UITableViewCell {
    var text: String? {
        get {
            if let content = self.contentConfiguration as? UIListContentConfiguration {
                
                return content.text
            }
            
            return nil
        }
        set {
            var content = self.defaultContentConfiguration()
            
            content.text = newValue
            
            self.contentConfiguration = content
            
        }
    }
}
