//
//  Joystick.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 28/09/23.
//

import SpriteKit

class Joystick {
    private var left = SKSpriteNode(texture: SKTexture(image: UIImage(systemName: "arrowtriangle.backward.circle.fill")!))
    private var right = SKSpriteNode(texture: SKTexture(image: UIImage(systemName: "arrowtriangle.right.circle.fill")!))
    var node = SKSpriteNode()
    var inUse = false
    var velocityX = 0.0
    
    
    init() {
        left.size = CGSize(width: 50, height: 50)
        right.size = CGSize(width: 50, height: 50)
        
        node.addChild(left)
        node.addChild(right)
        node.size = CGSize(width: left.frame.width + right.frame.width + 10, height: right.frame.height + left.frame.height)
        right.position = CGPoint(x: node.frame.midX + 5 + right.frame.width / 2, y: node.frame.midY)
        left.position = CGPoint(x: node.frame.midX - 5 - left.frame.width / 2, y: node.frame.midY)
    }
    
    func position(x: Double, y: Double) {
        node.position = CGPoint(x: x + 30 + node.frame.height / 2, y: y + 5 + node.frame.width / 2)
    }
    
    func touchMoved(touch: UITouch) {
        let location = touch.location(in: node)
        inUse = true
        if right.frame.contains(location) {
            velocityX = 10
        } else if left.frame.contains(location) {
            velocityX = -10
        }
    }
    
    func touchEnded() {
        inUse = false
        velocityX = 0
    }
    
}
