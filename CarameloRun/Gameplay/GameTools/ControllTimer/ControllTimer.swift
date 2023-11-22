//
//  Timer.swift
//  CarameloRun
//
//  Created by Luis Silva on 30/10/23.
//

import SpriteKit

class ControllTimer {
    var n: Int = 120

    var number = SKLabelNode(fontNamed: "Helvetica")
    var node = SKSpriteNode()
    
    init() {
        node.size = CGSize(width: Dimensions.buttonWidth.rawValue, height: Dimensions.buttonHeight.rawValue)
        let m = n/60
        let s = n%60
        number.text = "0\(m):0\(s)"
        number.fontColor = .blue
        
        node.addChild(number)
        node.scene?.backgroundColor = .blue
    }
    
    private func position(x: Double, y: Double) {
        node.position = CGPoint(x: x - 668, y: y + 540 + UIScreen.main.bounds.size.height/6)
    }
    
    func updateTimer(_ new: Int) {
        n = new
        let minutos = n / 60
        let segundos = n % 60
        var z = ""
        if segundos < 10 {
            z = "0"
        }
        number.text = "0\(minutos):\(z)\(segundos)"
    }
    
    func update(_ camera: SKCameraNode, _ frame: CGRect) {
        position(x: camera.position.x + frame.maxX,
                 y: camera.position.y - frame.maxY)
    }
}
