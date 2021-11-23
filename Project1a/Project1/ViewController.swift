//
//  ViewController.swift
//  Project1
//
//  Created by PEDRO HENRIQUE CALADO on 11/8/21.
//

import UIKit

class ViewController: UICollectionViewController, UINavigationControllerDelegate {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        performSelector(inBackground: #selector(getPictures), with: nil)
    }
    
    @objc func getPictures() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item.self)
            }
        }
        pictures.sort()
        performSelector(onMainThread: #selector(updateTable), with: nil, waitUntilDone: false)
    }
    
    @objc func updateTable() {
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return pictures.count
//    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? PictureCell else {
            fatalError("Can not converto to PictureCell")
        }
        cell.picture.image = UIImage(named: pictures[indexPath.item])
//        cell = pictures[indexPath.item]
//        var content = cell.defaultContentConfiguration()
//        content.textProperties.color = UIColor.systemPink
//        content.text = pictures[indexPath.row]
//        content.textProperties.font = UIFont.systemFont(ofSize: 35)
//        cell.contentConfiguration = content
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
//
//        //        cell.text = pictures[indexPath.row]
//        var content = cell.defaultContentConfiguration()
//        content.textProperties.color = UIColor.systemPink
//        content.text = pictures[indexPath.row]
//        content.textProperties.font = UIFont.systemFont(ofSize: 35)
//        cell.contentConfiguration = content
//        return cell
//    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.images = pictures
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
//            vc.selectedImage = pictures[indexPath.row]
//            vc.images = pictures
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pictures.sort()
    }
    
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        pictures.sort()
//    }
    
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

//extension UITableViewCell {
//    var text: String? {
//        get {
//            if let content = self.contentConfiguration as? UIListContentConfiguration {
//
//                return content.text
//            }
//
//            return nil
//        }
//        set {
//            var content = self.defaultContentConfiguration()
//
//            content.text = newValue
//
//            self.contentConfiguration = content
//
//        }
//    }
//}
