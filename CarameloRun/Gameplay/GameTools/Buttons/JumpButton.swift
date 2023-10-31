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
    
    private func position(x: Double, y: Double) {
        node.position = CGPoint(x: x - node.frame.width - 100, y: y + 80 + node.frame.height)
    }
    
    func touchBegan(_ touch: UITouch, _ scene: SKScene, _ player: Player) {
        let location = touch.location(in: scene)
        
        if(node.frame.contains(location)) {
            player.component(ofType: JumpComponent.self)?.jump()
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
