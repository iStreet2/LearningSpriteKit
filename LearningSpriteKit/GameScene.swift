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
    var enemyNode2 = SKSpriteNode(imageNamed: "enemy")
    var oliviaRodrigo = SKSpriteNode(imageNamed: "azeite")
    var initialPosition = CGPoint(x: 200, y: 200)
    var movableNode: SKNode?
    var square1 = SKShapeNode(rectOf: CGSize(width: 100, height: 100))
    var square2 = SKShapeNode(rectOf: CGSize(width: 100, height: 100))
    private var nodeValue = 1
    private var nodeValueLabel = SKLabelNode(fontNamed:"Times New Roman")
    
    override func didMove(to view: SKView) {
        start()
    }
    
    func start(){
        backgroundColor = .purple
        addEnemy(oliviaRodrigo, 200, 500)
        addEnemy(enemyNode, 200, 100)
        addEnemy(enemyNode2, 200, 300)
        setNodeValue()
        addInvisibleArea(square1, 100,200)
        addInvisibleArea(square2, 300, 200)
    }
    
    
    func addEnemy(_ node: SKSpriteNode, _ x: Int, _ y: Int){
        node.size = CGSize(width: 100, height: 100)
        node.position = CGPoint(x: x, y: y)
        addChild(node)
    }
    
    func setNodeValue(){
        self.nodeValueLabel.text = String(nodeValue)
        self.nodeValueLabel.fontSize = 50
        self.nodeValueLabel.position.x = initialPosition.x
        self.nodeValueLabel.position.y = initialPosition.y - 100
        self.addChild(self.nodeValueLabel)
    }
    
    func addInvisibleArea(_ node: SKShapeNode, _ x: Int, _ y: Int){
//        node.strokeColor = .clear
        node.position = CGPoint(x: x, y: y)
        addChild(node)
    }
    
    
    func giveDamage(_ node: SKSpriteNode, _ touches: Set<UITouch>){
        if let touch = touches.first{
            if node.contains(touch.location(in: self)){
                if gameModel!.life > 0{
                    gameModel?.life -= 10
                    if gameModel?.life == 0{
                        node.zRotation = .pi / 2
                    }
                }else{
                    gameModel?.life = 100
                    node.zRotation = 2*(.pi)
                }
            }
        }
    }
    
    func moveCharacter(_ node: SKSpriteNode, _ touches: Set<UITouch>, stage: Int){
        if stage == 0{
            if let touch = touches.first{
                let location = touch.location(in: self)
                if node.contains(location){
                    movableNode = node
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
                    duplicate(node, touches)
                    grabSprite(node, touches)
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
    
    func resetPosition(_ node: SKSpriteNode){
        node.position = initialPosition
        self.nodeValueLabel.position.x = initialPosition.x
        self.nodeValueLabel.position.y = initialPosition.y - 100
    }
    
    func duplicate(_ node: SKSpriteNode,_ touches: Set<UITouch>){
        if let touch = touches.first{
            if movableNode != nil{
                let location = touch.location(in: self)
                if oliviaRodrigo.contains(location){
                    nodeValue *= 2
                    nodeValueLabel.text = String(nodeValue)
                    gameModel!.life -= 1
                    resetPosition(node)
                    print(nodeValue)
                }
            }
        }
    }
    
    func grabSprite(_ node: SKSpriteNode,_ touches: Set<UITouch>){
        if let touch = touches.first{
            if movableNode != nil{
                let location = touch.location(in:self)
                if square1.contains(location){
                    node.position = CGPoint(x: 100, y: 200)
                    self.nodeValueLabel.position.x = node.position.x
                    self.nodeValueLabel.position.y = node.position.y - 100
                }else if square2.contains(location){
                    node.position = CGPoint(x: 300, y: 200)
                    self.nodeValueLabel.position.x = node.position.x
                    self.nodeValueLabel.position.y = node.position.y - 100
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { //Implementar logica para mexer só 1
        moveCharacter(enemyNode, touches, stage: 0)
        moveCharacter(enemyNode2, touches, stage: 0)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        moveCharacter(enemyNode, touches, stage: 1)
        moveCharacter(enemyNode2, touches, stage: 1)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if movableNode == enemyNode{
            moveCharacter(enemyNode, touches, stage: 2)
        }else{
            moveCharacter(enemyNode2, touches, stage: 2)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        moveCharacter(enemyNode, touches, stage: 3)
        moveCharacter(enemyNode2, touches, stage: 3)
        resetPosition(enemyNode)
        resetPosition(enemyNode2)
    }
}

