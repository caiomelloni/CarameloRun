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
       // node.size = CGSize(width: Dimensions.buttonWidth.rawValue, height: Dimensions.buttonHeight.rawValue)
        node.xScale = 1.35
        node.yScale = 1.35
    }
    
    private func position(x: Double, y: Double) {
        node.position = CGPoint(x: x - node.frame.width - 80, y: y + 45 + node.frame.height)
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
    
    func setJumpBtnPositionRelativeToCamera(_ camera: SKCameraNode, _ frame: CGRect) {
        position(
            x: camera.position.x + frame.maxX,
            y: camera.position.y - frame.maxY
        )
    }
    
    func update(_ camera: SKCameraNode, _ frame: CGRect) {
       setJumpBtnPositionRelativeToCamera(camera, frame)
    }
    

}
