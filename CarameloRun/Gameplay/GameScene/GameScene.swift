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
    
    let NTasksCompleted = TasksCompleted()
    
    var task1: Tasks! = nil
    var task2: Tasks! = nil
    var task3: Tasks! = nil
    
    var dogsCanBeAdopted: Bool = false
    
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
        joystick.addToScene(self)
        
        // set jump button
        addChild(jumpButton.node)
        jumpButton.setJumpBtnPositionRelativeToCamera(sceneCamera, frame)
        
        addChild(timer.node)
        
        addChild(NTasksCompleted.node)
        
        task1 = Tasks(scene! as! GameScene, (scene?.childNode(withName: "task1")!.frame)!, Constants.timerTask1BeAvaiable)
        task2 = Tasks(scene! as! GameScene, (scene?.childNode(withName: "task2")!.frame)!, Constants.timerTask2BeAvaiable)
        task3 = Tasks(scene! as! GameScene, (scene?.childNode(withName: "task3")!.frame)!, Constants.timerTask3BeAvaiable)
        
        InsertTask(task1)
        InsertTask(task2)
        InsertTask(task3)
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
        timer.update(sceneCamera, frame)
        NTasksCompleted.update(sceneCamera, frame)
        
        //game center online updates
        updatePlayerPositionForOtherPlayers()
        
        handlePlayerCollision()
        
        if !dogsCanBeAdopted {
            verifyDoingTask(task1)
            verifyDoingTask(task2)
            verifyDoingTask(task3)
        } else {
            verifyAdopted(task1)
            verifyAdopted(task2)
            verifyAdopted(task3)
        }
        
    }
    
    func getScore() -> Int{
        return entityManager.localPlayer!.component(ofType: ScoreComponent.self)?.score ?? 0
    }
    
    func getVictory() -> Bool{
        return entityManager.localPlayer!.component(ofType: ScoreComponent.self)?.victory ?? false
    }
}
