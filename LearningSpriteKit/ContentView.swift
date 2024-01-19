//
//  ContentView.swift
//  LearningSpriteKit
//
//  Created by Gabriel Vicentin Negro on 15/01/24.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    var gameModel: GameModel = GameModel()
    
    var scene: GameScene{
        let scene: GameScene = GameScene()
        scene.scaleMode = .resizeFill
        scene.gameModel = gameModel
        return scene
    }
    
    var body: some View {
        ZStack{
            GameView(scene: scene)
                .ignoresSafeArea()
            VStack{
                Text("\(gameModel.life)")
                Button(action: {
                    scene.view?.isPaused = true
                }
                , label: {
                    Text("Button")
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
