//
//  Manager.swift
//  Final Project Testing
//
//  Created by Ian Lommock on 10/30/22.
//

import Foundation

enum GameState {
    case paused, playing, end
}

class Manager : ObservableObject {
    
    //
    // published
    
    @Published var updateScreen : Bool = true
    @Published var gameState : GameState = .paused
    @Published var showEndSheet : Bool = false

    //
    // game info
    var score : Int = 0
    
    // player
    var player : Player = Player()
    
    // backgrounds
    var starBackgrounds : [Background] = []
    var roadBackgrounds : [Background] = []
    var planetBackgrounds : [Background] = []
    
    // obstacles
    var obstacles : [Obstacle] = []
    
    //
    // peristence
    var storageManager = StorageManager()
    var scores : [Score]
    
    //
    // init
    init() {
        var _scores : [Score]?
        storageManager.read(from: "Scores", to: &_scores)
        scores = _scores ?? []
    }
}

//
// persistence
extension Manager {
    
    func addScore(newScore : Int) {
        scores.append(Score(score: newScore, id: UUID()))
        save()
    }
    
    func save() {
        storageManager.write(to: "Scores", from: scores)
    }
    
}

//
// game operations
extension Manager {
    
    //
    // game state management
    func newGame() {
        gameState = .playing
        
        score = 0
        
        player = Player()
        
        starBackgrounds = []
        starBackgrounds.append(Background(imageName: "Stars0", offset: 0))
        starBackgrounds.append(Background(imageName: "Stars1", offset: SCREEN_WIDTH))
        
        roadBackgrounds = []
        roadBackgrounds.append(Background(imageName: ROAD_BACKGROUND_IMAGES.randomElement()!, offset: 0))
        roadBackgrounds.append(Background(imageName: ROAD_BACKGROUND_IMAGES.randomElement()!, offset: SCREEN_WIDTH))
        
        obstacles = []
        
        Thread.detachNewThreadSelector(#selector(gameController), toTarget: self, with: nil)
    }
    
    func endGame() {
        self.gameState = .end
    }
    
    func togglePause(_ isPaused : Bool) {
        self.gameState = isPaused ? .paused : .playing
    }
    
    //
    // player actions
    func jump() {
        player.counter = 0
        player.velocity = 5
        player.state = .jumping
    }
    
    func beginFloat() {
        player.counter = 0
        player.velocity = 0.3
        player.state = .floating
    }
    
    func endFloat() {
        player.counter = 0
        player.state = .falling
    }
    
    func collisionCheck(x1 : Double, y1 : Double, w1 : Double, h1 : Double, x2 : Double, y2 : Double, w2 : Double, h2 : Double) {

        let wB = w1/2 + w2/2
        let hB = h1/2 + h2/2
        
        if abs(x1 - x2) < wB-10 && abs(y1 - y2) < hB-5 {
            endGame()
        }
    }
    
    //
    // main gameplay loop
    @objc func gameController() {
        
        let sleepTime = 1.0 / Double(FPS)
        
        // counters
        var frameCounter = 0
        var starDec = 2.0 // base speed
        var roadDec = 6.0 // base speed
        
        
        var obstacleSpawnChance = 1.0
        
        var frameReg = Date()
                
        while (gameState != .end) {
            // regulate frame rate
            frameReg = frameReg.advanced(by: sleepTime)
            Thread.sleep(until: frameReg)

            // if paused, wait for game to unpause
            while (gameState == .paused) {
                frameReg = frameReg.advanced(by: sleepTime)
                Thread.sleep(until: frameReg)
            }
            
            //
            // player
            player.action(frame: frameCounter)
                    
            //
            // backgrounds
            
            // stars
            if let b = starBackgrounds.last, 0 <= b.offset && b.offset < starDec {
                starBackgrounds[0].offset = SCREEN_WIDTH
                starBackgrounds.swapAt(0, 1)
            }
            starBackgrounds[0].offset -= starDec
            starBackgrounds[1].offset -= starDec
            
            // road
            if let b = roadBackgrounds.last, 0 <= b.offset && b.offset < roadDec {
                roadBackgrounds.removeFirst()
                roadBackgrounds.append(Background(imageName: ROAD_BACKGROUND_IMAGES.randomElement()!, offset: SCREEN_WIDTH))
                
                // make obstacles
                if Double.random(in: 0.0..<1.0) <= obstacleSpawnChance {
                    obstacles.append(Obstacle(offset: SCREEN_WIDTH + Double.random(in: -1..<1) * (SCREEN_WIDTH/2)))
                }
            }
            roadBackgrounds[0].offset -= roadDec
            roadBackgrounds[1].offset -= roadDec
            
            // obstacles
            obstacles = obstacles.filter({ $0.offset > -SCREEN_WIDTH/2 - 500})
            
            for i in obstacles.indices {
                obstacles[i].offset -= roadDec
            }
            
            // update frame count
            frameCounter = (frameCounter + 1) % FPS
            
            // score
            if frameCounter == 0 { score += 1 }
            
            // difficulty increase
            if score % 20 == 0 && frameCounter == 0 && score != 0 {
                starDec += 1
                roadDec += 2
                obstacleSpawnChance += 0.05
            }
                        
            // send changes to main thread
            DispatchQueue.main.sync { self.updateScreen.toggle() }
        }
        
    }
    
}
