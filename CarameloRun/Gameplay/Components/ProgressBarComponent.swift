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
    var scene: SKScene
    var localPlayer: Player
    var timer: Timer!
    var time: Int = 15
    
    init(_ scene: SKScene, _ localPlayer: Player) {
        self.scene = scene
        self.localPlayer = localPlayer
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addProgressBar() {
        let task1 = scene.childNode(withName: "task1")!.frame
        progressBar = SKShapeNode(rectOf: CGSize(width: 100, height: 10))
        progressBar.fillColor = SKColor.black
        progressBar.position = CGPoint(x: task1.midX, y: task1.midY+80)
        progressBar.xScale = 0.00
        scene.addChild(progressBar)
    }
    
    func verify() {
        let task1 = scene.childNode(withName: "task1")!.frame
        
        if avaiable {
            
            if (task1.contains(localPlayer.component(ofType: SpriteComponent.self)!.position)) == true && localPlayer.type == .dog{
                progress += 0.01
                progressBar.xScale = progress
                
                if progress >= 1.00 {
                    entity?.component(ofType: CompleteTaskComponent.self)?.changeLabel(true)
                    avaiable = false
                    self.entity?.component(ofType: CompleteTaskComponent.self)?.ChangeAvaiable(false)
                    progressBar.xScale = 0.00
                    
                    initTimer()
                }
                
            } else {
                progress = 0.00
                entity?.component(ofType: CompleteTaskComponent.self)?.changeLabel(false)
                progressBar.xScale = progress
            }
        }
    }
    
    func initTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.time -= 1
            print(self.time)
            if self.time == 0 {
                self.avaiable = true
                self.entity?.component(ofType: CompleteTaskComponent.self)?.ChangeAvaiable(true)
                self.entity?.component(ofType: CompleteTaskComponent.self)?.changeLabel(false)
                timer.invalidate()
            }
        })
    }
}
