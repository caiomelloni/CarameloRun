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
        completeLabel.fontName = .localizedName(of: .symbol)
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
        if status && !(scene.dogsCanBeAdopted) {
            Label.text = ""
        } else {
            Label.text = "Indisponível"
        }
        Label.fontName = .localizedName(of: .symbol)
        Label.position = CGPoint(x: frame.midX, y: frame.midY+75)
        Label.fontColor = SKColor.black
        scene.addChild(Label)
    }
    
    func ChangeAvaiable(_ status: Bool) {
        if status && !(scene.dogsCanBeAdopted) {
            Label.text = ""
        } else {
            Label.text = "Indisponível"
        }
    }
    
    func dogsCanBeAdopted() {
        Label.text = "Entre para"
        completeLabel.text = "ser adotado"
    }
}
