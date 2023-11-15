//
//  PausedView.swift
//  Final Project Testing
//
//  Created by Ian Lommock on 11/16/22.
//

import SwiftUI

struct PausedView: View {
    
    @EnvironmentObject var manager : Manager
    
    var size : CGSize
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        let width = size.width * 0.45
        let height = size.height * 0.5
    
        HStack(alignment: .top) {
            VStack {
                Spacer()
                MenuButton(action: { manager.togglePause(false)}, text: "Resume", width: width * 0.45)
                .padding(.bottom)
                MenuButton(action: { manager.endGame() }, text: "Home", width: width * 0.45)
            }
            .padding()
            
            Spacer()
            
            Image(systemName: "gear")
                .font(.title2)
                .foregroundColor(.black)
            
        }
        .padding()
        .frame(width: width, height: height)
        .background(RoundedRectangle(cornerRadius: 30).fill(.white))
    }
}
