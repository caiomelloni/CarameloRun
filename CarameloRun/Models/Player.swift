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
    var node = SKSpriteNode(texture: SKTexture(imageNamed: "robot1"))
    private var currentPlayerSprite = 0
    var playerDirection: Direction = .right
    var playerNumber: Int
    let displayName: String
    
    var position: CGPoint {
        get {
            node.position
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
    
    func position(x: Double, y: Double) {
        node.position = CGPoint(x: x, y: y)
    }
    
    func addVelocity(dx: Double? = nil, dy: Double? = nil) {
        if let dx = dx {
            node.physicsBody?.velocity.dx = dx
            if dx > 0 {
                node.xScale = 1
                playerDirection = .right
            } else if dx < 0 {
                node.xScale = -1
                playerDirection = .left
            }
        }
        
        if let dy = dy {
            node.physicsBody?.velocity.dy = dy
        }
        
        
    }
    
}
