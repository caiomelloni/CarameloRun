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
        node.size = CGSize(width: Dimensions.buttonWidth.rawValue, height: Dimensions.buttonHeight.rawValue)
    }
    
    func position(x: Double, y: Double) {
        node.position = CGPoint(x: x - node.frame.width - 100, y: y + 30 + node.frame.height)
    }
    
    func buttonTapped(_ player: Player) {
        var direction = 1.00
        if player.playerDirection == .left {
            direction = -1
        }
        player.node.physicsBody?.applyImpulse(
            .init(dx: direction * node.size.width, dy: node.size.height * 5)
        )
    }
}
