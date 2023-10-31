//
//  Joystick.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 28/09/23.
//

import SpriteKit

class Joystick {
    private var left = SKSpriteNode(texture: SKTexture(image: UIImage(systemName: "arrowtriangle.backward.circle.fill")!))
    private var right = SKSpriteNode(texture: SKTexture(image: UIImage(systemName: "arrowtriangle.right.circle.fill")!))
    var node = SKSpriteNode()
    var inUse = false
    var movementDirection: Direction? = nil
    
    //valor padrão adicionado pelo joystick
    let defaultVelocity: Double = 100
    
    
    init() {
        
        node.zPosition = Zposition.joystick.rawValue
        
        let size = CGSize(width: Dimensions.buttonWidth.rawValue, height: Dimensions.buttonHeight.rawValue)
        left.size = size
        right.size = size
        
        node.addChild(left)
        node.addChild(right)
        node.size = CGSize(width: 2 * size.width + 10, height: size.height)
        right.position = CGPoint(x: node.frame.midX + 5 + right.frame.width / 2, y: node.frame.midY)
        left.position = CGPoint(x: node.frame.midX - 5 - left.frame.width / 2, y: node.frame.midY)
    }
    
    private func position(x: Double, y: Double) {
        node.position = CGPoint(x: x + 100 + node.frame.width / 2, y: y + 80 + node.frame.height)
    }
    
    func touchBegan(_ touch: UITouch) {
        let location = touch.location(in: node)

            if right.frame.contains(location) {
                inUse = true
                movementDirection = .right
            } else if left.frame.contains(location) {
                inUse = true
                movementDirection = .left
            }

    }
    
    func touchEnded(_ touch: UITouch, _ scene: SKScene) {
        let location = touch.location(in: scene)
        if node.frame.contains(location) {
            inUse = false
            movementDirection = nil
        }
    }
    
    func setJoystickPositionRelativeToCamera(_ camera: SKCameraNode, _ screenFrame: CGRect) {
        position(
            x: camera.position.x - screenFrame.maxX,
            y: camera.position.y - screenFrame.maxY
        )
    }
    
    func update(_ sceneCamera: SKCameraNode, _ frame: CGRect, _ dog: Player) {
        setJoystickPositionRelativeToCamera(sceneCamera, frame)
        
        if let movDirection = movementDirection {
            dog.component(ofType: VelocityComponent.self)?.addVelocity(movDirection)
        }
       
        let dy = dog.component(ofType: SpriteComponent.self)?.dy
        if(!inUse && dy == 0){
            dog.component(ofType: PlayerAnimationComponent.self)?.idle()
        }
    }
}
