//
//  ViewController.swift
//  Project18
//
//  Created by PEDRO HENRIQUE CALADO on 11/25/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(1, 2, 3, 4, separator: "-", terminator: "finish")
//        assert(1 == 2, "Failure")
        
        for i in 1...100 {
            print("Got number \(i)")
        }
    }


}

