//
//  JumpButton.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 28/09/23.
//

import SpriteKit

class JumpButton {
    var node = SKSpriteNode(texture: SKTexture(image: UIImage(systemName: "chevron.up.circle.fill")!))
    
    init() {
        node.size = CGSize(width: 50, height: 50)
    }
    
    func position(x: Double, y: Double) {
        node.position = CGPoint(x: x - node.frame.width, y: y + node.frame.height)
    }
}
