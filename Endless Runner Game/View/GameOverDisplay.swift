//
//  GameOverDisplay.swift
//  Endless Runner Game
//
//  Created by Ian Lommock on 12/11/22.
//

import SwiftUI

struct GameOverDisplay: View {
    
    @EnvironmentObject var manager : Manager
            
    var body: some View {
        
        HStack {
            
            VStack {
                Text("Game Over!")
                    .font(.system(.title2, design: .rounded))
                    .padding()
                Text("Score: \(manager.score)")
                    .font(.system(.title3, design: .monospaced))
            }
            
            Spacer()
            
            VStack {
                MenuButton(action: {manager.showEndSheet = false}, text: "Home", width: SCREEN_WIDTH * 0.2)
                    .padding()
                MenuButton(action: {manager.showEndSheet = false; manager.newGame()}, text: "Restart", width: SCREEN_WIDTH * 0.2)
            }
            
        }
        .onAppear(perform: { manager.addScore(newScore: manager.score) })
    }
}
