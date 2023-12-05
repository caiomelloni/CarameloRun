//
//  ComponentSystemExtension.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 29/11/23.
//

import GameplayKit

// Notifies everyone when something is added to scene
extension ComponentSystem {
    func notifyAddedToScene(scene: SKScene) {
        for comp in components(ofType: GetNotifiedWhenAddedToScene.self) {
            comp.didAddToScene(scene)
        }
    }
    
}

protocol GetNotifiedWhenAddedToScene {
    func didAddToScene(_ scene: SKScene)
}
