//
//  GameScene.swift
//  LearningSpriteKit
//
//  Created by Gabriel Vicentin Negro on 15/01/24.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    
    var gameModel: GameModel?
    var enemySize = CGSize(width: 100, height: 100)
    var enemyPosition = CGPoint(x: 200, y: 200)
    var enemyNode = SKSpriteNode(imageNamed: "enemy")
    
    
    override func didMove(to view: SKView) {
        start()
    }
    
    func start(){
        backgroundColor = .purple
        addEnemy()
    }
    
    func addEnemy(){
        enemyNode.size = enemySize
        enemyNode.position = enemyPosition
        addChild(enemyNode)
    }
    
    func shakeSprite(layer:SKSpriteNode, duration:Float) {
        
        let position = layer.position
        
        let amplitudeX:Float = 10
        let amplitudeY:Float = 6
        let numberOfShakes = duration / 0.04
        var actionsArray:[SKAction] = []
        for _ in 1...Int(numberOfShakes) {
            let moveX = Float(arc4random_uniform(UInt32(amplitudeX))) - amplitudeX / 2
            let moveY = Float(arc4random_uniform(UInt32(amplitudeY))) - amplitudeY / 2
            let shakeAction = SKAction.moveBy(x: CGFloat(moveX), y: CGFloat(moveY), duration: 0.02)
            shakeAction.timingMode = SKActionTimingMode.easeOut
            actionsArray.append(shakeAction)
            actionsArray.append(shakeAction.reversed())
        }
        
        actionsArray.append(SKAction.move(to: position, duration: 0.0))
        
        let actionSeq = SKAction.sequence(actionsArray)
        layer.run(actionSeq)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first!
        
        if enemyNode.contains(touch.location(in: self)){
            if gameModel!.life > 0{
                gameModel?.life -= 10
                shakeSprite(layer: enemyNode, duration: 0.3)
                if gameModel?.life == 0{
                    enemyNode.zRotation = .pi / 2
                }
            }else{
                gameModel?.life = 100
                enemyNode.zRotation = 2*(.pi)
            }
        }
    }
}
