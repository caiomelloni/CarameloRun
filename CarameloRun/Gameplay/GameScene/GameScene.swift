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
    
    // Update time
    var lastUpdateTimeInterval: TimeInterval = 0
    
    var entityManager: EntityManager!
    
    override func didMove(to view: SKView){
        entityManager = EntityManager(scene: self)
                
        backgroundColor = .white
        
        placePlayersInitialPositionInMap()
        
        // set camera
        sceneCamera = LocalPlayerCamera(entityManager.localPlayer!)
        camera = sceneCamera
        
        // set joystick
        addChild(joystick.node)
        joystick.setJoystickPositionRelativeToCamera(sceneCamera, frame)
        
        // set jump button
        addChild(jumpButton.node)
        jumpButton.setJumpBtnPositionRelativeToCamera(sceneCamera, frame)
        
        addChild(timer.node)
        
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
            joystick.touchEnded(t, self)
            jumpButton.touchEnded(t, self)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
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
        timer.update(sceneCamera, frame)
        
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

