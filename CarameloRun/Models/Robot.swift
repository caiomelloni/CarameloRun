//
//  Robot.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 28/09/23.
//

import SpriteKit

class Robot {
    var node = SKSpriteNode(texture: SKTexture(imageNamed: "robot1"))
    private var currentRobotSprite = 0
    
    func nextSprite() {
        currentRobotSprite += 1
        node.texture = SKTexture(imageNamed: "robot" + String(currentRobotSprite))
        if currentRobotSprite == 2 {
            currentRobotSprite = 0
        }
    }
    
    func position(x: Double, y: Double) {
        node.position = CGPoint(x: x + node.size.width / 2, y: y + node.size.height / 2)
    }
    
    func addMovementX(_ velocityX: Double) {
        node.position.x += velocityX
        if velocityX > 0 {
            node.xScale = 1
        } else if velocityX < 0 {
            node.xScale = -1
        }
    }
    
}
