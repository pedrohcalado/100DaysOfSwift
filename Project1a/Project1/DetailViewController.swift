//
//  DetailViewController.swift
//  Project1
//
//  Created by PEDRO HENRIQUE CALADO on 11/9/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var ImageView: UIImageView!
    
    var selectedImage: String?
    var images: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedImage = selectedImage, let images = images, let index = images.firstIndex(of: selectedImage) {
            title = "Picture \(index + 1) of \(images.count)"
            navigationItem.largeTitleDisplayMode = .never
        } else {
            title = selectedImage
        }
        
        
        if let imageToLoad = selectedImage {
            ImageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
