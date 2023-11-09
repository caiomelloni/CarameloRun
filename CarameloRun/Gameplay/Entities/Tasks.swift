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
    var scene: SKScene
    var localPlayer: Player
    
    init(_ scene: SKScene, _ localPlayer: Player) {
        self.scene = scene
        self.localPlayer = localPlayer
        
        super.init()
        
        let components = [
            ProgressBarComponent(scene, localPlayer),
            CompleteTaskComponent(scene)
        ]
        
        components.forEach{ component in
            addComponent(component)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
