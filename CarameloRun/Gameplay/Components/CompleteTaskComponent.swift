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
    var scene: SKScene
    var completeLabel = SKLabelNode()
    var Label = SKLabelNode()
    
    init(_ scene: SKScene) {
        self.scene = scene
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCompleteLabel() {
        let task1 = scene.childNode(withName: "task1")!.frame
        completeLabel = SKLabelNode()
        completeLabel.fontName = "San Francisco"
        completeLabel.position = CGPoint(x: task1.midX, y: task1.midY+30)
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
        let task1 = scene.childNode(withName: "task1")!.frame
        if status{
            Label.text = "Disponível"
        } else {
            Label.text = "Indisponível"
        }
        Label.fontName = "San Francisco"
        Label.position = CGPoint(x: task1.midX, y: task1.midY+100)
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
