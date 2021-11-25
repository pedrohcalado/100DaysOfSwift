//
//  ViewController.swift
//  Project1
//
//  Created by PEDRO HENRIQUE CALADO on 11/8/21.
//

import UIKit

class ViewController: UITableViewController {
//    var pictures = [String]()
    var pictures = [Picture]()
    var picturesData = [Picture]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let defaults = UserDefaults.standard
        if let savedPictures = defaults.object(forKey: "pictures") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                picturesData = try jsonDecoder.decode([Picture].self, from: savedPictures)
            } catch {
                print("Failed to load picture data.")
            }
        }
        
        performSelector(inBackground: #selector(getPictures), with: nil)
    }
    
//    func getPicturesClickCount() {
//        picturesData.forEach ({ pictures.
//        }) })
//    }
    
    @objc func getPictures() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                let picture = Picture(name: item.self)
                pictures.append(picture)
            }
        }
        pictures.sort { $0.name < $1.name}
        performSelector(onMainThread: #selector(updateTable), with: nil, waitUntilDone: false)
    }
    
    @objc func updateTable() {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        //        cell.text = pictures[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.textProperties.color = UIColor.systemPink
        content.text = pictures[indexPath.row].name
        content.textProperties.font = UIFont.systemFont(ofSize: 35)
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let timesClicked = pictures.filter { $0.name == pictures[indexPath.row].name }.first?.timesClicked ?? 0
        
        let ac = UIAlertController(title: "Times clicked", message: "The image \(pictures[indexPath.row].name) was clicked \(timesClicked) times", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pictures[indexPath.row].click()
        
        let jsonEncoder = JSONEncoder()
        
        if let data = try? jsonEncoder.encode(pictures) {
            let defaults = UserDefaults.standard
            defaults.set(data, forKey: "pictures")
        } else {
            print("Failed to save picture data")
        }
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            
            vc.images = pictures
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        pictures.sort { $0.name < $1.name }
    }
    
    @objc func shareTapped() {
//        guard let image = ImageView.image?.jpegData(compressionQuality: 0.8) else {
//            print("No image found")
//            return
//        }
        
        let vc = UIActivityViewController(activityItems: ["Best app in the world"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(vc, animated: true)
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
