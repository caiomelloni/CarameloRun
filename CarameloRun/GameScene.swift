//
//  GameScene.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 28/09/23.
//

import SpriteKit
import GameplayKit
import GameKit

class GameScene: SKScene {
    
    let robot = Player()
    let robot2 = Player()
    let joystick = Joystick()
    let jumpButton = JumpButton()
    let sceneCamera = SKCameraNode()
    var controllerDelegate: GameControllerDelegate?
    var playerNumber: Int?
    
    override func didMove(to view: SKView){
        backgroundColor = .white
        
        playerNumber = controllerDelegate!.getPlayerNumber()
        robot2.node.physicsBody?.affectedByGravity = false
        addChild(robot2.node)
        
        let spawnNode = scene?.childNode(withName: "spawn\(playerNumber!)")
        
        camera = sceneCamera
        
        robot.position(x: spawnNode!.position.x, y: spawnNode!.position.y)
        addChild(robot.node)
        
        addChild(joystick.node)
        
        addChild(jumpButton.node)
        
        positionJoysticksAndJumpBtn()
        
    }
    
    func positionJoysticksAndJumpBtn() {
        joystick.position(
            x: sceneCamera.position.x - frame.maxX,
            y: sceneCamera.position.y - frame.maxY
        )
        jumpButton.position(
            x: sceneCamera.position.x + frame.maxX,
            y: sceneCamera.position.y - frame.maxY
        )
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
    
    func updatePlayersPosition(x: Double, y: Double) {
       let newPosition = CGPoint(x: x, y: y)
        robot2.node.position = newPosition
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        updateCameraPosition()
        positionJoysticksAndJumpBtn()
        
        robot.addMovementX(joystick.velocityX)
            
        let playerState = PlayerState(name: GKLocalPlayer.local.displayName,
                                          positionX: robot.node.position.x,
                                          positionY: robot.node.position.y)
            
        controllerDelegate?.sendPlayerState(playerState)
        
        if(joystick.inUse){
            robot.nextSprite()
        }
    }
}
