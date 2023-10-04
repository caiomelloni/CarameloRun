//
//  GameScene.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 28/09/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let robot = Player()
    let joystick = Joystick()
    let jumpButton = JumpButton()
    let sceneCamera = SKCameraNode()
   
    override func didMove(to view: SKView){
        backgroundColor = .white
        
        camera = sceneCamera
        
        robot.position(x: view.frame.midX, y: view.frame.minY)
        addChild(robot.node)
        
        addChild(joystick.node)
       
        addChild(jumpButton.node)
        
        positionJoysticksAndJumpBtn()
        
    }
    
    func positionJoysticksAndJumpBtn() {
        
        joystick.position(x: sceneCamera.position.x - frame.maxX, y: sceneCamera.position.y - frame.maxY)

        
        jumpButton.position(x: sceneCamera.position.x + frame.maxX, y: sceneCamera.position.y - frame.maxY)
    }
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            
            if(joystick.node.frame.contains(location)) {
                joystick.touchMoved(touch: t)
            }
            
            if(jumpButton.node.frame.contains(location)) {
                jumpButton.buttonTapped(robot)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            if joystick.node.frame.contains(location) {
                joystick.touchEnded()
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    func updateCameraPosition() {
        camera?.position.x = robot.node.position.x
        camera?.position.y = robot.node.position.y
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        updateCameraPosition()
        positionJoysticksAndJumpBtn()
        
        robot.addMovementX(joystick.velocityX)
        
        if(joystick.inUse){
            robot.nextSprite()
        }
    }
}
