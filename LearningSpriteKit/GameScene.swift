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
    var enemyNode = SKSpriteNode(imageNamed: "enemy")
    var oliviaRodrigo = SKSpriteNode(imageNamed: "azeite")
    var initialPosition = CGPoint(x: 200, y: 200)
    var movableNode: SKNode?
    
    private var nodeValue = 1
    
    private var nodeValueLabel = SKLabelNode(fontNamed:"Times New Roman")
    
    override func didMove(to view: SKView) {
        start()
    }
    
    func start(){
        backgroundColor = .purple
        addEnemy(enemyNode, initialPosition)
        addEnemy(oliviaRodrigo, CGPoint(x: 200, y: 500))
        setNodeValue()
    }
    
    func addEnemy(_ node: SKSpriteNode, _ location: CGPoint){
        node.size = CGSize(width: 100, height: 100)
        node.position = location
        addChild(node)
    }
    
    func setNodeValue(){
        self.nodeValueLabel.text = String(nodeValue)
        self.nodeValueLabel.fontSize = 50
        self.nodeValueLabel.position.x = initialPosition.x
        self.nodeValueLabel.position.y = initialPosition.y - 100
        self.addChild(self.nodeValueLabel)
//        nodeValueLabel.position.x = enemyNode.position.x
//        nodeValueLabel.position.y = enemyNode.position.y
    }
    
    func giveDamage(_ touches: Set<UITouch>){
        if let touch = touches.first{
            if enemyNode.contains(touch.location(in: self)){
                if gameModel!.life > 0{
                    gameModel?.life -= 10
//                    shakeSprite(layer: enemyNode, duration: 0.3)
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
    
    func moveCharacter(_ touches: Set<UITouch>, stage: Int){
        if stage == 0{
            if let touch = touches.first{
                let location = touch.location(in: self)
                if enemyNode.contains(location){
                    movableNode = enemyNode
                    movableNode!.position = location
                    self.nodeValueLabel.position.x = movableNode!.position.x
                    self.nodeValueLabel.position.y = movableNode!.position.y - 100
                }
            }
        }else if stage == 1{
            if let touch = touches.first {
                if movableNode != nil{
                    movableNode!.position = touch.location(in: self)
                    self.nodeValueLabel.position.x = movableNode!.position.x
                    self.nodeValueLabel.position.y = movableNode!.position.y - 100
                }
            }
            
        }else if stage == 2{
            if let touch = touches.first {
                if movableNode != nil{
                    movableNode!.position = touch.location(in: self)
                    self.nodeValueLabel.position = touch.location(in: self)
                    self.nodeValueLabel.position.x = movableNode!.position.x
                    self.nodeValueLabel.position.y = movableNode!.position.y - 100
                    duplicate(touches)
                    movableNode = nil
                }
            }
            
        }else{
            if let _ = touches.first {
                if movableNode != nil{
                    movableNode = nil
                }
            }
        }
    }
    
    func resetPosition(){
        enemyNode.position = initialPosition
        self.nodeValueLabel.position.x = initialPosition.x
        self.nodeValueLabel.position.y = initialPosition.y - 100
    }
    
    func duplicate(_ touches: Set<UITouch>){
        if let touch = touches.first{
            if movableNode != nil{
                let location = touch.location(in: self)
                if oliviaRodrigo.contains(location){
                    nodeValue *= 2
                    nodeValueLabel.text = String(nodeValue)
                    resetPosition()
                    print(nodeValue)
                }
            }
        }
    }
            
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        moveCharacter(touches, stage: 0)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        moveCharacter(touches, stage: 1)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        moveCharacter(touches, stage: 2)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        moveCharacter(touches, stage: 3)
        resetPosition()
    }
}

