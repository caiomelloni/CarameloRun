//
//  CompleteTaskComponent.swift
//  CarameloRun
//
//  Created by Luis Silva on 08/11/23.
//

import GameplayKit
import SpriteKit

class CompleteTaskComponent: GKComponent {
    var complete: Bool = false
    var scene: GameScene
    var completeLabel = SKLabelNode()
    var Label = SKLabelNode()
    var frame: CGRect
    var tasksCompleted: Int = 0
    
    init(_ scene: GameScene, _ frame: CGRect) {
        self.scene = scene
        self.frame = frame
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCompleteLabel() {
        completeLabel = SKLabelNode()
        completeLabel.fontName = "San Francisco"
        completeLabel.position = CGPoint(x: frame.midX, y: frame.midY+30)
        completeLabel.fontColor = SKColor.black
        scene.addChild(completeLabel)
    }
    
    func changeLabel(_ x: Bool) {
        if x {
            completeLabel.text = "Task Completa"
        } else {
            completeLabel.text = ""
        }
    }
    
    func TaskAvaiable(_ status: Bool){
        if status{
            Label.text = "Disponível"
        } else {
            Label.text = "Indisponível"
        }
        Label.fontName = "San Francisco"
        Label.position = CGPoint(x: frame.midX, y: frame.midY+100)
        Label.fontColor = SKColor.black
        scene.addChild(Label)
    }
    
    func ChangeAvaiable(_ status: Bool) {
        if status{
            Label.text = "Disponível"
        } else {
            Label.text = "Indisponível"
        }
    }
}
