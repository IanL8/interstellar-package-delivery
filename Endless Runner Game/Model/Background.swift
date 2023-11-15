//
//  Background.swift
//  Final Project Testing
//
//  Created by Ian Lommock on 10/30/22.
//

import Foundation

let STAR_BACKGROUND_IMAGES : [String] = ["Stars0", "Stars1"]

let ROAD_BACKGROUND_IMAGES : [String] = ["Road0", "Road1", "Road2"]

struct Background : Identifiable {
    let imageName : String
    var offset : Double
    
    let id = UUID()
    
    init(imageName: String, offset: Double) {
        self.imageName = imageName
        self.offset = offset
    }
}
