//
//  JumpButton.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 28/09/23.
//

import SpriteKit

class JumpButton {
    var node = SKSpriteNode(texture: SKTexture(imageNamed: "JumpButtonUp"))

    init() {
        node.size = CGSize(width: Dimensions.buttonWidth.rawValue, height: Dimensions.buttonWidth.rawValue)
        node.zPosition = Zposition.joystick.rawValue
    }
    
    private func position(x: Double, y: Double) {
        node.position = CGPoint(x: x - node.frame.width - 80, y: y + 85 + node.frame.height)
    }
    
    func touchBegan(_ touch: UITouch, _ scene: SKScene, _ player: Player) {
        let location = touch.location(in: scene)
        
        if(node.frame.contains(location)) {
            player.component(ofType: JumpComponent.self)?.jump()
            node.texture = SKTexture(imageNamed: "JumpButtonDown")
        }
    }
    
    func touchEnded(_ touch: UITouch, _ scene: SKScene) {
        let location = touch.location(in: scene)
        
        if(node.frame.contains(location)) {
                node.texture = SKTexture(imageNamed: "JumpButtonUp")
        }
    }
    
    func setJumpBtnPositionRelativeToCamera(_ camera: LocalPlayerCamera, _ screenFrame: CGRect) {
        position(
            x: camera.position.x + screenFrame.maxX * camera.scaleFactorX,
            y: camera.position.y - screenFrame.maxY * camera.scaleFactorY
        )
    }
    
    func update(_ camera: LocalPlayerCamera, _ frame: CGRect) {
       setJumpBtnPositionRelativeToCamera(camera, frame)
    }
    

}
