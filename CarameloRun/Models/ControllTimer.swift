//
//  Timer.swift
//  CarameloRun
//
//  Created by Luis Silva on 30/10/23.
//

import SpriteKit

class ControllTimer {
    var n: Int = 15
    var number = SKLabelNode(fontNamed: "Helvetica")
    var node = SKSpriteNode()
    
    init() {
        node.size = CGSize(width: Dimensions.buttonWidth.rawValue, height: Dimensions.buttonHeight.rawValue)
        number.text = "timer: \(n)"
        number.fontColor = .blue
        
        
        node.addChild(number)
        node.scene?.backgroundColor = .blue
    }
    
    func position(x: Double, y: Double) {
        node.position = CGPoint(x: x - node.frame.width - 400, y: y + 400 + node.frame.height)
    }
    
    func updateTimer(_ new: Int) {
        n = new
        number.text = "timer: \(n)"
    }
}
