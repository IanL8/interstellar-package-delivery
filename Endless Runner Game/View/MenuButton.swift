//
//  MenuButton.swift
//  Endless Runner Game
//
//  Created by Ian Lommock on 12/11/22.
//

import SwiftUI

struct MenuButton: View {
    
    var action : () -> Void
    var text : String
    var width : Double
    
    var body: some View {
        
        Button(action: action) {
            Text(text)
                .frame(width: width)
        }
        .buttonStyle(.borderedProminent)
    }
}
