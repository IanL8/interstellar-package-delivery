//
//  Player.swift
//  Final Project Testing
//
//  Created by Ian Lommock on 10/30/22.
//

import Foundation

//
// sprite info
let PLAYER_RUNNING_SPRITES : [String] = ["Rover0", "Rover1", "Rover2", "Rover3", "Rover4", "Rover5"]
let PRS_COUNT = PLAYER_RUNNING_SPRITES.count

//
// player state
enum PlayerState : String, Identifiable {
    case running, jumping, falling, floating
    var id : RawValue { self.rawValue }
    
}

//
// player
struct Player {
    var state : PlayerState = .running
    var sprite : String = PLAYER_RUNNING_SPRITES[0]
    var counter : Int = 0
    var offset : Double = 0
    var velocity : Double = 0
    
    
    mutating func action(frame f : Int) {
        switch (state) {
        case .running:
            if (f + 1) % 3 == 0 {
                sprite = PLAYER_RUNNING_SPRITES[counter]
                counter = (counter + 1) % PRS_COUNT
            }
        case .jumping:
            offset -= (velocity * HEIGHT_UNIT)
            velocity = velocity - velocity / 10
            if velocity <= 0.1 {
                velocity = 0.3
                state = .falling
            }
        case .falling:
            offset += (velocity * HEIGHT_UNIT)
            velocity += velocity < 2 ? velocity / 15 : 0
            if offset >= 0 {
                offset = 0
                velocity = 0
                state = .running
                counter = 0
            }
            
        case .floating:
            offset += (0.3 * HEIGHT_UNIT)
            if offset >= 0 {
                offset = 0
                velocity = 0
                state = .running
                counter = 0
            }
        }
    }
}
