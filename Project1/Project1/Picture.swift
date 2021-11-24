//
//  Picture.swift
//  Project1
//
//  Created by Pedro Henrique Calado on 23/11/21.
//

import Foundation

struct Picture: Equatable, Codable {
    let name: String
    var timesClicked: Int
    
    init(name: String) {
        self.name = name
        self.timesClicked = 0
    }
    
    mutating func click() {
        self.timesClicked += 1
    }
}
