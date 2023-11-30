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
    
    //sprite frames updates changes controll
    private var oldPosition =  CGPoint(x: 0, y: 0)
    private var positionChangedOnFrameUpdate = false
    private var oldState: String?
    

    init(imageName: String, size: CGSize) {
        node = SKSpriteNode(imageNamed: imageName)
        node.size = size
        super.init()
        node.entity = entity
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var size: CGSize {
        get {
            node.size
        }
    }
    
    var frame: CGRect {
        get {
            node.frame
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
        node.removeFromParent()
        scene.addChild(node)
        setReferencePosition()
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
    
    override func update(deltaTime seconds: TimeInterval) {
        positionChangedOnFrameUpdate = position.x != oldPosition.x || position.y != oldPosition.y
        oldPosition = CGPoint(x: position.x, y: position.y)
    }
    
    private func setReferencePosition() {
        oldPosition = CGPoint(x: position.x, y: position.y)
        oldState = (entity?.component(ofType: PlayerAnimationComponent.self)?.stateMachine.currentState as? CodableState)?.stringIdentifier
    }
    
    func hasChanged() -> Bool {
//        let hasStateChanged = entity?.component(ofType: PlayerAnimationComponent.self)?.hasStateChanged() ?? false
        let hasStateChanged = false
        
        let hasChanged = positionChangedOnFrameUpdate || hasStateChanged


        
        return hasChanged
    }
    
}
