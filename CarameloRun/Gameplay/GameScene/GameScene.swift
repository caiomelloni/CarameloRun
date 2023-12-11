//
//  GameScene.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 28/09/23.
//

import SpriteKit
import GameplayKit
import GameKit

// just implement overrided functions in the main class
// avoid bussiness logic in this file
// place another functions in extensions
class GameScene: SKScene {
    
    let joystick = Joystick()
    let jumpButton = JumpButton()
    var sceneCamera: LocalPlayerCamera!
    let localPlayerPositionHistory = PositionHistory()
    var controllerDelegate: GameControllerDelegate?
    let timer = ControllTimer()

    var hud: HUD?


    // Update time
    var lastUpdateTimeInterval: TimeInterval = 0

    var entityManager: EntityManager!

    override func sceneDidLoad() {

    }

    override func didMove(to view: SKView){


        backgroundColor = .white
        placePlayersInitialPositionInMap()
        entityManager = EntityManager(scene: self)
        var allPlayers = [entityManager.localPlayer]
        for player in entityManager.remotePlayers {
            allPlayers.append(LocalPlayer(displayName: player.displayName, playerNumber: player.playerNumber, playerType: player.type, photo: player.photo))
            print(player)
        }


        hud = HUD(width: self.frame.width, height: self.frame.height, players: allPlayers)

        // set camera
        sceneCamera = LocalPlayerCamera(entityManager.localPlayer!)
        camera = sceneCamera
        
        // set joystick
        joystick.addToScene(self)
        
        // set jump button
        addChild(jumpButton.node)
        jumpButton.setJumpBtnPositionRelativeToCamera(sceneCamera, frame)
        
//        addChild(timer.node)


        addChild(hud?.hudNode ?? SKNode())

        InsertTask()

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            joystick.touchBegan(t)
            jumpButton.touchBegan(t, self, entityManager.localPlayer!)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            joystick.touchEnded(t)
            jumpButton.touchEnded(t, self)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    func joystickStateChanged(inUse: Bool, direction: Direction) {
        entityManager.joystickStateChanged(inUse: inUse, direction: direction)
    }
    
    // Called before each frame is rendered
    override func update(_ currentTime: TimeInterval) {
        
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        //call updates
        entityManager.update(deltaTime)
        sceneCamera.update(deltaTime)
        joystick.update(sceneCamera, frame, entityManager.localPlayer!)
        jumpButton.update(sceneCamera, frame)
//        timer.update(sceneCamera, frame)
        hud?.update(sceneCamera, frame)

        //game center online updates
        updatePlayerPositionForOtherPlayers()
        
        handlePlayerCollision()
        
        verifyDoingTask()
        
    }
    
    func getScore() -> Int{
        return entityManager.localPlayer!.component(ofType: ScoreComponent.self)?.score ?? 0
    }
    
    func getVictory() -> Bool{
        return entityManager.localPlayer!.component(ofType: ScoreComponent.self)?.victory ?? false
    }
}

