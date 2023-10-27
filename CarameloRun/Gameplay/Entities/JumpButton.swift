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
        node.position = CGPoint(x: x - node.frame.width - 100, y: y + 80 + node.frame.height)
    }
    
    func buttonTapped(_ player: Player) {
        player.component(ofType: JumpComponent.self)?.jump()
    }
}
