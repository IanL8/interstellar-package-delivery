//
//  HighScores.swift
//  Endless Runner Game
//
//  Created by Ian Lommock on 12/11/22.
//

import Foundation


struct Score : Identifiable, Codable {
    let score : Int
    var id : UUID
}
