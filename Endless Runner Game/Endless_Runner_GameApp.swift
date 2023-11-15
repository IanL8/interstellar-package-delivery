//
//  Endless_Runner_GameApp.swift
//  Endless Runner Game
//
//  Created by Ian Lommock on 11/20/22.
//

import SwiftUI

@main
struct Endless_Runner_GameApp: App {
    @StateObject var manager : Manager = Manager()
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(manager)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .background:
                break
            case .active:
                break
            case .inactive:
                manager.gameState = .paused
                manager.save()
            @unknown default:
                assert(false, "Unknown scene phase")
            }
        }
    }
}
