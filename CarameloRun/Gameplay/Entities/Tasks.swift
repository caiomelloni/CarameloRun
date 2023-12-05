//
//  Tasks.swift
//  CarameloRun
//
//  Created by Luis Silva on 08/11/23.
//

import SpriteKit
import GameplayKit
import GameKit

class Tasks: GKEntity {
    var scene: GameScene
    var frame: CGRect
    var possibleTimeToDoTheTask: Int
    
    init(_ scene: GameScene, _ frame: CGRect,_ possibleTimeToDoTheTask: Int) {
        self.scene = scene
        self.frame = frame
        self.possibleTimeToDoTheTask = possibleTimeToDoTheTask
        
        super.init()
        
        let components = [
            ProgressBarComponent(scene, frame, possibleTimeToDoTheTask),
            CompleteTaskComponent(scene, frame),
            CanBeAdoptedComponent(scene, frame)
        ]
        
        components.forEach{ component in
            addComponent(component)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
