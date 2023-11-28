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
    
    var localPlayer: Player!
    var remotePlayers = [Int:Player]()
    let joystick = Joystick()
    let jumpButton = JumpButton()
    var sceneCamera: LocalPlayerCamera!
    let localPlayerPositionHistory = PositionHistory()
    var controllerDelegate: GameControllerDelegate?
    let timer = ControllTimer()
    
    let NTasksCompleted = TasksCompleted()
    
    var task1: Tasks! = nil
    var task2: Tasks! = nil
    var task3: Tasks! = nil
    
    // Update time
    var lastUpdateTimeInterval: TimeInterval = 0
    
    var entityManager: EntityManager!
    
    override func didMove(to view: SKView){
        entityManager = EntityManager(scene: self)
                
        backgroundColor = .white
        
        placePlayersInitialPositionInMap()
        
        // set camera
        sceneCamera = LocalPlayerCamera(localPlayer)
        camera = sceneCamera
        
        // set joystick
        addChild(joystick.node)
        joystick.setJoystickPositionRelativeToCamera(sceneCamera, frame)
        
        // set jump button
        addChild(jumpButton.node)
        jumpButton.setJumpBtnPositionRelativeToCamera(sceneCamera, frame)
        
        addChild(timer.node)
        
        addChild(NTasksCompleted.node)
        
        task1 = Tasks(scene! as! GameScene, (scene?.childNode(withName: "task1")!.frame)!)
        task2 = Tasks(scene! as! GameScene, (scene?.childNode(withName: "task2")!.frame)!)
        task3 = Tasks(scene! as! GameScene, (scene?.childNode(withName: "task3")!.frame)!)
        
        InsertTask(task1)
        InsertTask(task2)
        InsertTask(task3)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            joystick.touchBegan(t)
            jumpButton.touchBegan(t, self, localPlayer)
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
        joystick.update(sceneCamera, frame, localPlayer)
        jumpButton.update(sceneCamera, frame)
        timer.update(sceneCamera, frame)
        NTasksCompleted.update(sceneCamera, frame)
        
        //game center online updates
        updatePlayerPositionForOtherPlayers()
        
        handlePlayerCollision()
        
        verifyDoingTask(task1)
        verifyDoingTask(task2)
        verifyDoingTask(task3)
        
    }
    
    func getScore() -> Int{
        return localPlayer.component(ofType: ScoreComponent.self)?.score ?? 0
    }
    
    func getVictory() -> Bool{
        return localPlayer.component(ofType: ScoreComponent.self)?.victory ?? false
    }
}

