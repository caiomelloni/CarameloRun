//
//  SpriteComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 26/10/23.
//

import SpriteKit
import GameplayKit

class SpriteComponent: GKComponent {
    private let node: SKSpriteNode

    init(texture: SKTexture, size: CGSize) {
        node = SKSpriteNode(texture: texture)
        node.size = size
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var size: CGSize {
        get {
            node.size
        }
    }
    
    
    var physicsBody: SKPhysicsBody? {
        get {
            node.physicsBody
        }
        set {
            node.physicsBody = newValue
        }
    }
    
    var zPosition: CGFloat {
        get {
            node.zPosition
        }
        set {
            node.zPosition = newValue
        }
    }
    
    var position: CGPoint {
        get {
            node.position
        }
        set {
            node.position = newValue
        }
    }
    
    func addToScene(_ scene: SKScene) {
        scene.addChild(node)
    }
   
    func removeFromParent() {
        node.removeFromParent()
    }
    
    var texture: SKTexture? {
        get {
            node.texture
        }
        set {
            node.texture = newValue
        }
    }
    
    var xScale: CGFloat {
        get {
            node.xScale
        }
        set {
            node.xScale = newValue
        }
    }
    
    func run(_ action: SKAction) {
        node.run(action)
    }
    
    var dy: CGFloat? {
        get {
            node.physicsBody?.velocity.dy
        }
    }
    
}

