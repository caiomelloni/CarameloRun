//
//  Joystick.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 28/09/23.
//

import SpriteKit

class Joystick {
    private var left = SKSpriteNode(texture: SKTexture(imageNamed: "ButtonLeftUp"))
    private var right = SKSpriteNode(texture: SKTexture(imageNamed: "ButtonRightUp"))
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
        node.size = CGSize(width: left.size.width + right.size.width, height: size.height)
        node.xScale = 1.3
        node.yScale = 1.3
        right.position = CGPoint(x: node.frame.midX + 5 + right.frame.width / 2, y: node.frame.midY)
        left.position = CGPoint(x: node.frame.midX - 5 - left.frame.width / 2, y: node.frame.midY)
    }
    
    private func position(x: Double, y: Double) {
        node.position = CGPoint(x: x + 150 + node.frame.width / 2, y: y + 120 + node.frame.height)
    }
    
    func touchBegan(_ touch: UITouch) {
        let location = touch.location(in: node)

            if right.frame.contains(location) {
                inUse = true
                movementDirection = .right
                right.texture = SKTexture(imageNamed: "ButtonRightDown")
                
            } else if left.frame.contains(location) {
                inUse = true
                movementDirection = .left
                left.texture = SKTexture(imageNamed: "ButtonLeftDown")

            }

    }
    
    func touchEnded(_ touch: UITouch, _ scene: SKScene) {
        let location = touch.location(in: scene)
        if node.frame.contains(location) {
            inUse = false
            movementDirection = nil
            right.texture = SKTexture(imageNamed: "ButtonRightUp")
            left.texture = SKTexture(imageNamed: "ButtonLeftUp")
        }
    }
    
    func setJoystickPositionRelativeToCamera(_ camera: LocalPlayerCamera, _ screenFrame: CGRect) {
        position(
            x: camera.position.x - screenFrame.maxX * camera.scaleFactorX,
            y: camera.position.y - screenFrame.maxY * camera.scaleFactorY
        )
    }
    
    func update(_ sceneCamera: LocalPlayerCamera, _ frame: CGRect, _ player: LocalPlayer) {
        setJoystickPositionRelativeToCamera(sceneCamera, frame)
        
        let velocityComponent = player.component(ofType: VelocityComponent.self)
        
        if let movDirection = movementDirection {
            velocityComponent?.addVelocity(movDirection)
        }
       
        if !inUse {
            velocityComponent?.stop()
        }
        
    }
}
