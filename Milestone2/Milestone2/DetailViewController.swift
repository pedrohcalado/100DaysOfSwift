//
//  DetailViewController.swift
//  Milestone2
//
//  Created by PEDRO HENRIQUE CALADO on 11/16/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var flagView: UIImageView!
    
    //    @IBOutlet weak var flagView: UIImageView!
    
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = selectedImage {
//            view.center = CGPoint(x: 100, y: 100)
//            print(view.center)
//            flagView.center.x = view.center.x
//            flagView.center.y = view.center.y
            flagView.translatesAutoresizingMaskIntoConstraints = false
            flagView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
            print(flagView.constraints)
            flagView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
            flagView.image = UIImage(named: image)
            flagView.layer.borderWidth = CGFloat(1)
            flagView.layer.borderColor = UIColor.red.cgColor
            flagView.sizeToFit()
            
            
            
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareTapped))
        
        
    }
    
    @objc func shareTapped() {
        let alert = UIAlertController(title: "Just share it", message: "Lets", preferredStyle: .alert)
        let action = UIAlertAction(title: "Share it", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
