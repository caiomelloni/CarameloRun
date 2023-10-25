//
//  Robot.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 28/09/23.
//

import SpriteKit

enum Direction {
    case right
    case left
}

class Player {
    private var node = SKSpriteNode(texture: SKTexture(imageNamed: "robot1"))
    private var currentPlayerSprite = 0
    var playerDirection: Direction = .right
    var playerNumber: Int
    let displayName: String
    
    var position: CGPoint {
        get {
            node.position
        }
        set {
            let dx = node.position.x - newValue.x
            if dx < 0 {
                changePlayerDirection(.right)
            } else if dx > 0 {
                changePlayerDirection(.left)
            }
            node.position = newValue
        }
    }
    
    var affectedByGravity: Bool? {
        set {
            if let newValue = newValue {
                node.physicsBody?.affectedByGravity = newValue
            }
        }
        
        get {
            node.physicsBody?.affectedByGravity
        }
    }
    
    init(displayName: String, playerNumber: Int) {
        let body = SKPhysicsBody(rectangleOf: node.size)
        body.affectedByGravity = true
        body.allowsRotation = false
        
        node.physicsBody = body
        
        node.zPosition = Zposition.player.rawValue
        
        self.displayName = displayName
        self.playerNumber = playerNumber
    }
    
    func nextSprite() {
        currentPlayerSprite += 1
        node.texture = SKTexture(imageNamed: "robot" + String(currentPlayerSprite))
        if currentPlayerSprite == 2 {
            currentPlayerSprite = 0
        }
    }
    
    func addVelocity(dx: Double? = nil, dy: Double? = nil) {
        if let dx = dx {
            node.physicsBody?.velocity.dx = dx
            if dx > 0 {
                changePlayerDirection(.right)
            } else if dx < 0 {
                changePlayerDirection(.left)
            }
        }
        
        if let dy = dy {
            node.physicsBody?.velocity.dy = dy
        }
    }
    
    func jump() {
        if node.physicsBody?.velocity.dy != 0 {
            return
        }
        var direction = 1.00
        if playerDirection == .left {
            direction = -1
        }
        node.physicsBody?.applyImpulse(
            .init(dx: direction * node.size.width, dy: node.size.height * 5)
        )
    }
    
    func addToScene(_ scene: SKScene) {
        scene.addChild(node)
    }
    
    func changePlayerDirection(_ direction: Direction) {
        switch direction {
        case .right:
            node.xScale = 1
            playerDirection = .right
        case .left:
            node.xScale = -1
            playerDirection = .left
        }
    }
}
