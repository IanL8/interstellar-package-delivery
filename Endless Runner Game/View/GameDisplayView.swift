//
//  GameView.swift
//  Final Project Testing
//
//  Created by Ian Lommock on 10/30/22.
//

import SwiftUI

struct GameDisplayView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var manager : Manager
    
    var body: some View {
        GeometryReader { gr in
            let swipe = DragGesture(minimumDistance: 0).onChanged { _ in
                if (manager.player.state == .falling || manager.player.state == .jumping) {
                    manager.beginFloat()
                }
            }.onEnded { val in
                if (manager.player.state == .floating) {
                    manager.endFloat()
                    return
                }
                
                guard (manager.player.state == .running) else { return }
                
                if (val.translation.height < 0) {
                    // up
                    manager.jump()
                }
            }

            ZStack {
                GameView(gr: gr, size: gr.size, playerSize: gr.size.height * 0.3)
                    .gesture(swipe)
                
                if (manager.gameState == .paused) {
                    Color(.gray).opacity(0.5)
                    PausedView(size: gr.size)
                }
            }
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) { PauseButton(togglePause: manager.togglePause, gameState: manager.gameState) }
            ToolbarItem(placement: .navigationBarLeading) { ScoreDisplay(score: manager.score) }
        }
        .sheet(isPresented: $manager.showEndSheet, onDismiss: { if manager.gameState == .end { dismiss()}}) {
            GameOverDisplay()
        }
        .onAppear {
            manager.newGame()
        }
    }
}

struct PauseButton : View {
    let togglePause : (Bool) -> Void
    let gameState : GameState
    var paused : Bool {gameState == .paused}
    
    var body : some View {
        
        Button(action: { togglePause(true) }) {
            Image(systemName: paused ? "play.fill" : "pause.fill")
                .font(.largeTitle)
        }
        .disabled(paused)
        
    }
}

struct ScoreDisplay : View {
    let score : Int
    var body : some View {
        Text("\(score)")
            .foregroundColor(.white)
            .font(.system(.title3, design: .monospaced))
    }
}
