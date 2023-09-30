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
    let ground = Ground()
    
   
    override func didMove(to view: SKView){
        backgroundColor = .white
        
        ground.position(x: view.frame.midX, y: view.frame.minY)
        addChild(ground.node)
        
        robot.position(x: view.frame.midX, y: view.frame.minY)
        addChild(robot.node)
        
        joystick.position(x: view.frame.minX, y: view.frame.minY)
        addChild(joystick.node)
       
        jumpButton.position(x: view.frame.maxX, y: view.frame.minY)
        addChild(jumpButton.node)
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
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        robot.addMovementX(joystick.velocityX)
        
        if(joystick.inUse){
            robot.nextSprite()
        }
    }
}
