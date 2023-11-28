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
    var timer: Timer!
    var time: Int = 15
    var frame: CGRect
    
    init(_ scene: GameScene, _ frame: CGRect) {
        self.scene = scene
        self.frame = frame
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addProgressBar() {
        progressBar = SKShapeNode(rectOf: CGSize(width: 100, height: 10))
        progressBar.fillColor = SKColor.black
        progressBar.position = CGPoint(x: frame.midX, y: frame.midY+80)
        progressBar.xScale = 0.00
        scene.addChild(progressBar)
        
    }
    
    func verify() {
        
        if avaiable {
            
            self.entity?.component(ofType: CompleteTaskComponent.self)?.ChangeAvaiable(true)
            self.entity?.component(ofType: CompleteTaskComponent.self)?.changeLabel(false)

            //TODO: fazer com que as tasks apareça que está sendo feita, para todos os jogadores
            
            var thereAreSomeoneInsideTheTask = 0
            for player in scene.remotePlayers.values {
                
                if player.type == .dog {
                    if (frame.contains((player.component(ofType: SpriteComponent.self)!.position))) == true {
                        progress += 0.01
                        progressBar.xScale = progress
                    } else {
                        thereAreSomeoneInsideTheTask += 1
                    }
                }
            }
            
            if scene.localPlayer.type == .dog {
                
                if (frame.contains((scene.localPlayer.component(ofType: SpriteComponent.self)!.position))) == true {
                    progress += 0.01
                    progressBar.xScale = progress
                } else {
                    thereAreSomeoneInsideTheTask += 1
                }
            }
            
            if progress >= 1.50 {
                entity?.component(ofType: CompleteTaskComponent.self)?.changeLabel(true)
                avaiable = false
                self.entity?.component(ofType: CompleteTaskComponent.self)?.ChangeAvaiable(false)
                progressBar.xScale = 0.00
                if (frame.contains((scene.localPlayer.component(ofType: SpriteComponent.self)!.position))) == true && scene.localPlayer.type == .dog{
                    scene.localPlayer.component(ofType: ScoreComponent.self)?.dogMakeTask()
                    
                    //send data
                    let state = taskDone(frameOfTheTask: frame, done: true)
                    scene.controllerDelegate?.sendTaskDone(state)
                    scene.controllerDelegate?.addOneTaskDone(frame)
                }
                initTimer()
                
            }
            
            if thereAreSomeoneInsideTheTask == scene.remotePlayers.count {
                progress = 0.00
                entity?.component(ofType: CompleteTaskComponent.self)?.changeLabel(false)
                progressBar.xScale = progress
            }
        }
    }
    
    func initTimer() {
        var x = time
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            x -= 1
            if x == 0 {
                self.avaiable = true
                timer.invalidate()
            }
        })
    }
}
