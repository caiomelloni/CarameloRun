//
//  Ground.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 30/09/23.
//

import SpriteKit

class Ground {
    var node = SKSpriteNode()
    
    init() {
        node.color = .red
        node.size = CGSize(width: 800, height: 10)
        
        let body = SKPhysicsBody(rectangleOf: node.size)
        body.affectedByGravity = true
        body.allowsRotation = false
        body.isDynamic = false
        
        node.physicsBody = body
    }
    
    func position(x: Double, y: Double) {
        node.position = CGPoint(x: x, y: y)
    }
}
