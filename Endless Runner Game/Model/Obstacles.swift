//
//  Obstacles.swift
//  Endless Runner Game
//
//  Created by Ian Lommock on 12/11/22.
//

import Foundation

let OBSTACLE_IMAGES : [String] = ["Obstacle0", "Obstacle1"]

struct Obstacle : Identifiable {
    let imageName : String
    let width : Double
    let height : Double
    
    var offset : Double
    
    let id = UUID()
    
    init(offset: Double) {
        self.offset = offset
        
        switch (Int.random(in: 0..<2)) {
        case 0:
            self.imageName = "Obstacle0"
            self.width = SCREEN_HEIGHT * 0.15
            self.height = SCREEN_HEIGHT * 0.15
        default:
            self.imageName = "Obstacle1"
            self.width = SCREEN_HEIGHT * 0.107143
            self.height = SCREEN_HEIGHT * 0.3
        }
    }
}
