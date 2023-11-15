//
//  InnerGameView.swift
//  Final Project Testing
//
//  Created by Ian Lommock on 11/16/22.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var manager : Manager

    let gr : GeometryProxy
    let size : CGSize
    let playerSize : CGFloat

    var objectHeight : CGFloat {size.height - size.height * 0.05}

    var playerHeight : CGFloat {objectHeight - playerSize/2}
        
    var midX : CGFloat {size.width / 2}
    
    var body: some View {
        
        ZStack {
            // backgrounds
            ForEach(manager.starBackgrounds) { b in
                BackgroundView(image: b.imageName, height: size.height, offset: CGSize(width: b.offset, height: 0))
            }
            
            ForEach(manager.roadBackgrounds) { b in
                BackgroundView(image: b.imageName, height: size.height, offset: CGSize(width: b.offset, height: 0))
            }
            
            // player
            Image(manager.player.sprite)
                .resizable()
                .frame(width: playerSize, height: playerSize)
                .position(x: playerSize, y: playerHeight)
                .offset(CGSize(width: 0, height: manager.player.offset))
            
            // obstacles
            ForEach(manager.obstacles) { o in
                Image(o.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: o.width, height: o.height)
                    .position(x: midX, y: (objectHeight + o.height/2) - o.height)
                    .offset(CGSize(width: o.offset, height: 0))
                    .onChange(of: o.offset) { _ in
                        
                        let y2 = (objectHeight + o.height/2) - o.height
                        
                        manager.collisionCheck(x1: playerSize, y1: playerHeight + manager.player.offset, w1: playerSize, h1: playerSize,
                                               x2: midX + o.offset, y2: y2, w2: o.width, h2: o.height)
                    }
            }
        }
        .onChange(of: manager.gameState) {n in
            if n == GameState.end {
                manager.showEndSheet.toggle()
            }
        }
    }
}

struct BackgroundView : View {
    
    var image : String
    var height : CGFloat
    var offset : CGSize
    
    var body : some View {
        Image(image)
            .resizable()
            .frame(height: height)
            .offset(offset)
    }
}

