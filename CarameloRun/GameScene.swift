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
    
    var robot: Player?
    var robots = [Int:Player]()
    let joystick = Joystick()
    let jumpButton = JumpButton()
    let sceneCamera = SKCameraNode()
    var controllerDelegate: GameControllerDelegate?
    
    override func didMove(to view: SKView){
        backgroundColor = .white
        let players = controllerDelegate?.getAllPlayers2()
        
        
        if let players = players {
            for player in players {
                if player.displayName == GKLocalPlayer.local.displayName {
                    robot = Player(displayName: player.displayName, playerNumber: player.playerNumber)
                    
                    let spawnNode = scene?.childNode(withName: "spawn\(robot!.playerNumber)")
                    
                    robot!.position(x: spawnNode!.position.x, y: spawnNode!.position.y)
                    addChild(robot!.node)
                    continue
                }
                
                robots[player.playerNumber] = player
                player.node.physicsBody?.affectedByGravity = false
                let spawnNode = scene?.childNode(withName: "spawn\(player.playerNumber)")
                player.position(x: spawnNode!.position.x, y: spawnNode!.position.y)
                addChild(player.node)
            }
        } else {
            print("ERROR: NULL PLAYERS")
        }
        
        
        
        
        camera = sceneCamera
        
        
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
                jumpButton.buttonTapped(robot!)
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
        camera?.position.x = robot!.node.position.x
        camera?.position.y = robot!.node.position.y
    }
    
    func updatePlayersPosition(_ playerState: PlayerState) {
        let newPosition = CGPoint(x: playerState.positionX, y: playerState.positionY)
        robots[playerState.playerNumber]?.node.position = newPosition
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        updateCameraPosition()
        positionJoysticksAndJumpBtn()
        
        robot!.addMovementX(joystick.velocityX)
        
        let playerState = PlayerState(name: GKLocalPlayer.local.displayName,
                                      playerNumber: robot!.playerNumber,
                                      positionX: robot!.node.position.x,
                                      positionY: robot!.node.position.y)
        
        controllerDelegate?.sendPlayerState(playerState)
        
        if(joystick.inUse){
            robot!.nextSprite()
        }
    }
}
