//
//  GameView.swift
//  LearningSpriteKit
//
//  Created by Gabriel Vicentin Negro on 15/01/24.
//

import SwiftUI
import SpriteKit


struct GameView: View{
    
    var scene: GameScene
    
    var body: some View{
        SpriteView(scene: scene)
    }
}

