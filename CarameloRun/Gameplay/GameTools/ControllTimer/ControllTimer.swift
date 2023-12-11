//
//  Timer.swift
//  CarameloRun
//
//  Created by Luis Silva on 30/10/23.
//

import SpriteKit

class ControllTimer {
    var n: Int = Constants.gameTime

    var number = SKLabelNode(fontNamed: "Crang")
    var node = SKSpriteNode()
    
    init() {
        node.size = CGSize(width: Dimensions.buttonWidth.rawValue, height: Dimensions.buttonHeight.rawValue)
        let m = n/60
        let s = n%60
        let timerImage = timerAsset()
        number.text = "0\(m):0\(s)"
        number.fontSize = 48
        number.fontColor = .black

        timerImage.position = CGPoint(x: -(Int(timerImage.size.width * 0.7)), y: 0)
        number.position = CGPoint(x: Int(timerImage.position.x) + Int(timerImage.size.width), y: -(Dimensions.buttonHeight.rawValue)/4)
        node.addChild(timerImage)
        node.addChild(number)


        node.scene?.backgroundColor = .blue

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
    
    func timerAsset() -> SKSpriteNode {
        let timerImageNode: SKSpriteNode = SKSpriteNode()
        timerImageNode.texture = SKTexture(image: UIImage(named: "timer") ?? UIImage())
        timerImageNode.size = CGSize(width: Dimensions.buttonWidth.rawValue, height: Dimensions.buttonHeight.rawValue)
        timerImageNode.zPosition = Zposition.hud.rawValue
        return timerImageNode
    }

}
