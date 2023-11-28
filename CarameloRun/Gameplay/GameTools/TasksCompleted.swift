//
//  TasksCompleted.swift
//  CarameloRun
//
//  Created by Luis Silva on 28/11/23.
//

import SpriteKit

class TasksCompleted {
    var numberLabel = SKLabelNode()
    var node = SKSpriteNode()
    
    init() {
        node.size = CGSize(width: Dimensions.buttonWidth.rawValue, height: Dimensions.buttonHeight.rawValue)
        numberLabel.text = "Tasks Completas: 0"
        numberLabel.fontName = .localizedName(of: .symbol)
        numberLabel.fontColor = .purple
        node.addChild(numberLabel)
    }
    
    private func position(x: Double, y: Double) {
        node.position = CGPoint(x: x - 1168, y: y + 540 + UIScreen.main.bounds.size.height/6)
    }
    
    func updateNumberOfTasksCompleted(_ n: Int) {
        numberLabel.text = "Tasks completas: \(n)"
    }
    
    func update(_ camera: SKCameraNode, _ frame: CGRect) {
        position(x: camera.position.x + frame.maxX,
                 y: camera.position.y - frame.maxY)
    }
}
