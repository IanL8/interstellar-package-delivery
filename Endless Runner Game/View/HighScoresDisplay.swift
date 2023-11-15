//
//  HighScoresDisplay.swift
//  Endless Runner Game
//
//  Created by Ian Lommock on 12/11/22.
//

import SwiftUI

struct HighScoresDisplay: View {
    
    @EnvironmentObject var manager : Manager

    
    var body: some View {
        HStack(alignment: .top) {
            
            Spacer()
            
            if (!manager.scores.isEmpty) {
                List {
                    ForEach(manager.scores.sorted(by: {$0.score > $1.score})) {s in
                        Text("\(s.score)")
                    }
                }
                .listStyle(.plain)
            } else {
                Text("No scores")
                    .padding()
            }
        }
        .navigationTitle("High Scores")
    }
}
