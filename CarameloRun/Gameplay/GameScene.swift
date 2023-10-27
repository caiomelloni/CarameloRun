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
    
    var robot: Player!
    var robots = [Int:Player]()
    let joystick = Joystick()
    let jumpButton = JumpButton()
    let sceneCamera = SKCameraNode()
    let positionHistory = PositionHistory()
    var controllerDelegate: GameControllerDelegate?
    
    // Update time
    var lastUpdateTimeInterval: TimeInterval = 0
    
    var entityManager: EntityManager!
    
    override func didMove(to view: SKView){
       entityManager = EntityManager(scene: self)
        
        backgroundColor = .white
        let players = controllerDelegate?.getAllPlayers2()
        
        
        if let players = players {
            for player in players {
                
                let spawnNode = scene?.childNode(withName: "spawn\(player.playerNumber)")
                
                entityManager.addEntity(player, spawnPoint: spawnNode?.position)
                
                if player.displayName == GKLocalPlayer.local.displayName {
                    robot = player
                    positionHistory.setReferencePosition(player)
                } else {
                    // TO DO: tirar gravidade e proibir que um player empurre o outro
                    // o no do player deve ser um ponto fixo no mapa, que se movimenta apenas pelas
                    // coordenadas emitidas
                    // player.component(ofType: SpriteComponent.self).affectedByGravity = false
                    robots[player.playerNumber] = player
                }
                
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
        camera?.position.x = robot.component(ofType: SpriteComponent.self)!.position.x
        camera?.position.y = robot.component(ofType: SpriteComponent.self)!.position.y
    }
    
    func updatePlayersPosition(_ playerState: PlayerState) {
        let newPosition = CGPoint(x: playerState.positionX, y: playerState.positionY)
        robots[playerState.playerNumber]?.component(ofType: SpriteComponent.self)?.position = newPosition
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        entityManager.update(deltaTime)
        
        updateCameraPosition()
        positionJoysticksAndJumpBtn()
        
        if let movDirection = joystick.movementDirection {
            robot?.component(ofType: VelocityComponent.self)?.addVelocity(movDirection)
        }
        
        if positionHistory.hasPositionChanged(robot!) {
            let playerState = PlayerState(name: GKLocalPlayer.local.displayName,
                                          playerNumber: robot.playerNumber,
                                          positionX: robot.component(ofType: SpriteComponent.self)!.position.x,
                                          positionY: robot.component(ofType: SpriteComponent.self)!.position.y)
            
            controllerDelegate?.sendPlayerState(playerState)
        }
        
        
        if(joystick.inUse){
            robot.component(ofType: SpriteWalkAnimationComponent.self)?.nextSprite()
        }
    }
}
