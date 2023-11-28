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
    
    init(_ scene: GameScene, _ frame: CGRect) {
        self.scene = scene
        self.frame = frame
        
        super.init()
        
        let components = [
            ProgressBarComponent(scene, frame),
            CompleteTaskComponent(scene, frame)
        ]
        
        components.forEach{ component in
            addComponent(component)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
