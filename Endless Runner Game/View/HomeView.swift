//
//  HomeView.swift
//  Final Project Testing
//
//  Created by Ian Lommock on 11/16/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var manager : Manager
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .center) {
                Text("Interstellar Package Delivery")
                    .foregroundColor(.gray)
                    .font(.system(.title, design: .rounded))
                    .padding(.bottom)
            
                MenuLink(dest: AnyView(GameDisplayView().navigationBarBackButtonHidden(true)), text: "New Game")
                .padding()
                MenuLink(dest: AnyView(HighScoresDisplay()), text: ("High Scores"))
            }
        }
    }
}

struct MenuLink : View {
    var dest : AnyView
    var text : String
    var body : some View {
        NavigationLink(destination: dest) { Text(text).frame(width: SCREEN_WIDTH * 0.3) }
        .buttonStyle(.borderedProminent)
    }
}
