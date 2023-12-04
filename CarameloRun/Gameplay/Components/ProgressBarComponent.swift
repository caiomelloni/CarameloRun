//
//  ProgressBarComponent.swift
//  CarameloRun
//
//  Created by Luis Silva on 08/11/23.
//

import GameplayKit
import SpriteKit

class ProgressBarComponent: GKComponent {
    
    var avaiable: Bool = false
    var progress: CGFloat = 0.00
    var progressBar = SKShapeNode()
    var scene: GameScene
    var timer1: Timer!
    var timer2: Timer!
    var timerOfTheTaskAvaiableThatApearsForThePlayer = SKLabelNode()
    var timerForThrTaskBeAvaiableAgain: Int = Constants.timerForThrTaskBeAvaiableAgain
    var possibleTimeToDoTheTask: Int
    var frame: CGRect
    var alreadyStartTheTimer: Bool = false
    
    init(_ scene: GameScene, _ frame: CGRect, _ possibleTimeToDoTheTask: Int) {
        self.scene = scene
        self.frame = frame
        self.possibleTimeToDoTheTask = possibleTimeToDoTheTask
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addProgressBar() {
        progressBar = SKShapeNode(rectOf: CGSize(width: 100, height: 10))
        progressBar.fillColor = SKColor.black
        progressBar.position = CGPoint(x: frame.midX, y: frame.midY+50)
        progressBar.xScale = 0.00
        scene.addChild(progressBar)
        
    }
    
    func addTimer() {
        timerOfTheTaskAvaiableThatApearsForThePlayer.text = ""
        timerOfTheTaskAvaiableThatApearsForThePlayer.fontName = .localizedName(of: .symbol)
        timerOfTheTaskAvaiableThatApearsForThePlayer.fontColor = .black
        timerOfTheTaskAvaiableThatApearsForThePlayer.position = CGPoint(x: frame.midX, y: frame.maxY - 60)
        scene.addChild(timerOfTheTaskAvaiableThatApearsForThePlayer)
    }
    
    func verifyIfIsDoingTask() {
        
        if avaiable {
            
            if !alreadyStartTheTimer{
                initTimerThatIsPossibleToDoTheTask()
            }
            
            self.entity?.component(ofType: CompleteTaskComponent.self)?.ChangeAvaiable(true)
            self.entity?.component(ofType: CompleteTaskComponent.self)?.changeLabel(false)

            var thereAreSomeoneInsideTheTask = 0
            for player in scene.entityManager.remotePlayers {
                
                if player.type == .dog {
                    if (frame.contains((player.component(ofType: SpriteComponent.self)!.position))) == true {
                        progress += 0.01
                        progressBar.xScale = progress
                    } else {
                        thereAreSomeoneInsideTheTask += 1
                    }
                }
            }
            
            if scene.entityManager.localPlayer!.type == .dog {
                
                if (frame.contains((scene.entityManager.localPlayer!.component(ofType: SpriteComponent.self)!.position))) == true {
                    progress += 0.01
                    progressBar.xScale = progress
                } else {
                    thereAreSomeoneInsideTheTask += 1
                }
            }
            
            if progress >= 2.00 {
                entity?.component(ofType: CompleteTaskComponent.self)?.changeLabel(true)
                avaiable = false
                if (frame.contains((scene.entityManager.localPlayer!.component(ofType: SpriteComponent.self)!.position))) == true && scene.entityManager.localPlayer!.type == .dog{
                    scene.entityManager.localPlayer!.component(ofType: ScoreComponent.self)?.dogMakeTask()
                    
                    //send data
                    let state = taskDone(frameOfTheTask: frame, done: true)
                    scene.controllerDelegate?.sendTaskDone(state)
                    scene.controllerDelegate?.addOneTaskDone(frame)
                }
                initTimerFotTheTaskBeAvaiableAgain()
                
            }
            
            if thereAreSomeoneInsideTheTask == scene.entityManager.remotePlayers.count {
                progress = 0.00
                entity?.component(ofType: CompleteTaskComponent.self)?.changeLabel(false)
                progressBar.xScale = progress
            }
        }
    }
    
    func initTimerFotTheTaskBeAvaiableAgain() {
        self.entity?.component(ofType: CompleteTaskComponent.self)?.ChangeAvaiable(false)
        self.timerOfTheTaskAvaiableThatApearsForThePlayer.text = ""
        progressBar.xScale = 0.00
        var x = timerForThrTaskBeAvaiableAgain
        timer1 = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            x -= 1
            if x == 0 {
                self.avaiable = true
                self.alreadyStartTheTimer = false
                self.progress = 0.00
                self.timer2.invalidate()
            }
        })
    }
    
    
    func initTimerThatIsPossibleToDoTheTask() {
        self.alreadyStartTheTimer = true
        var y = possibleTimeToDoTheTask
        timer2 = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer2) in
            if self.avaiable {
                self.updateTimer(y)
                y -= 1
                if y == -1 { //coloquei -1 pq estava parando no 00:02
                    self.avaiable = false
                    self.initTimerFotTheTaskBeAvaiableAgain()
                    self.alreadyStartTheTimer = false
                    self.progress = 0.00
                    self.timer2.invalidate()
                }
            } else {
                self.alreadyStartTheTimer = false
                self.timer2.invalidate()
            }
        })
    }
    
    func updateTimer(_ new: Int) {
        let n = new
        let minutos = n / 60
        let segundos = n % 60
        var z = ""
        if segundos < 10 {
            z = "0"
        }
        timerOfTheTaskAvaiableThatApearsForThePlayer.text = "Disponível: 0\(minutos):\(z)\(segundos)"
    }
}
