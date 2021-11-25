//
//  DetailViewController.swift
//  Project1
//
//  Created by PEDRO HENRIQUE CALADO on 11/9/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var ImageView: UIImageView!
    
    var selectedImage: Picture?
    var images: [Picture]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(selectedImage != nil, "Selected image is nil")
        if let selectedImage = selectedImage, let images = images, let index = images.firstIndex(where: { $0.name == selectedImage.name }) {
            title = "Picture \(index + 1) of \(images.count)"
            navigationItem.largeTitleDisplayMode = .never
        } else {
            title = selectedImage?.name
        }
        
        
        if let imageToLoad = selectedImage {
            ImageView.image = UIImage(named: imageToLoad.name)
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
