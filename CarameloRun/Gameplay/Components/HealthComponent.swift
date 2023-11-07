//
//  HealthComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 07/11/23.
//

import GameplayKit

class HealthComponent: GKComponent {
    private var healthPoints = 2
    var killPlayerRef: (() -> Void)?
    
    func decreaseLife() {
        healthPoints -= 1
        if healthPoints == 0 {
            entity?.component(ofType: SpriteComponent.self)?.removeFromParent()
            killPlayerRef?()
        }
    }
}
