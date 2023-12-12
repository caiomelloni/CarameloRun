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
    private var inUse = false
    private var movementDirection: Direction = .right
    private var scene: GameScene?
    private var node = SKSpriteNode()
    private var currentTouch: UITouch?
    
    
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
    
    func addToScene(_ scene: GameScene) {
        self.scene = scene
        scene.addChild(node)
        setJoystickPositionRelativeToCamera(scene.sceneCamera, scene.frame)
    }
    
    func touchBegan(_ touch: UITouch) {
        let location = touch.location(in: node)
        
        if right.frame.contains(location) {
            inUse = true
            movementDirection = .right
            currentTouch = touch
            right.texture = SKTexture(imageNamed: "ButtonRightDown")
            
        } else if left.frame.contains(location) {
            inUse = true
            movementDirection = .left
            currentTouch = touch
            left.texture = SKTexture(imageNamed: "ButtonLeftDown")
            
        }
        
        scene?.joystickStateChanged(inUse: inUse, direction: movementDirection)
        
        
    }
    
    func touchEnded(_ touch: UITouch) {
        let location = touch.location(in: scene!)
        if currentTouch == touch {
            inUse = false
            right.texture = SKTexture(imageNamed: "ButtonRightUp")
            left.texture = SKTexture(imageNamed: "ButtonLeftUp")
        }
        scene!.joystickStateChanged(inUse: inUse, direction: movementDirection)
        
    }
    
    func touchMoved(_ touch: UITouch){
        let location = touch.location(in: node)
        
        if right.frame.contains(location) {
            inUse = true
            movementDirection = .right
            right.texture = SKTexture(imageNamed: "ButtonRightDown")
            left.texture = SKTexture(imageNamed: "ButtonLeftUp")
        }
        
        if left.frame.contains(location) {
            inUse = true
            movementDirection = .left
            left.texture = SKTexture(imageNamed: "ButtonLeftDown")
            right.texture = SKTexture(imageNamed: "ButtonRightUp")
        }
        
        scene?.joystickStateChanged(inUse: inUse, direction: movementDirection)
        
    }
    
    func setJoystickPositionRelativeToCamera(_ camera: LocalPlayerCamera, _ screenFrame: CGRect) {
        position(
            x: camera.position.x - screenFrame.maxX * camera.scaleFactorX,
            y: camera.position.y - screenFrame.maxY * camera.scaleFactorY
        )
    }
    
    func update(_ sceneCamera: LocalPlayerCamera, _ frame: CGRect, _ player: LocalPlayer) {
        setJoystickPositionRelativeToCamera(sceneCamera, frame)
    }
    
    func removeFromScene() {
        node.removeFromParent()
    }
    
}
