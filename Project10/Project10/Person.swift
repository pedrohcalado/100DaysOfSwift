//
//  Person.swift
//  Project10
//
//  Created by Pedro Henrique Calado on 22/11/21.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
