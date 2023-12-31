//
//  SpriteComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 26/10/23.
//

import SpriteKit
import GameplayKit

class SpriteComponent: GKComponent {
    let node: SKSpriteNode
    
    //sprite frames updates changes controll
    private var oldPosition =  CGPoint(x: 0, y: 0)
    private var positionChangedOnFrameUpdate = false
    

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

            let oldX = position.x
            
            let directionComp = entity?.component(ofType: DirectionComponent.self)
            directionComp?.positionChanged(oldX, newValue.x)
            
            node.position = newValue
        }
    }
    
    func addToScene(_ scene: SKScene) {
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
    }
    
    func hasChanged() -> Bool {
        let hasStateChanged = entity?.component(ofType: PlayerStateComponent.self)?.hasStateChanged() ?? false
        
        let hasChanged = positionChangedOnFrameUpdate || hasStateChanged


        
        return hasChanged
    }
    
    var contactTestBitMask: UInt32? {
        get {
            node.physicsBody?.contactTestBitMask
        }
        set {
            guard let newValue = newValue else {
                return
            }
            node.physicsBody?.contactTestBitMask = newValue
        }
    }
    
    override func didAddToEntity() {
        node.entity = self.entity
    }
    
    var dx: CGFloat? {
        get {
            node.physicsBody?.velocity.dy
        }
        set {
            node.physicsBody?.velocity.dx = newValue ?? 0
        }
    }
    
}
