//
//  GetCaughtComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 07/11/23.
//

import GameplayKit

class GetCaughtComponent: GKComponent {
    func gotCaught(_ respawn: CGPoint) {
        entity?.component(ofType: SpriteComponent.self)?.position = respawn
        
        entity?.component(ofType: ScoreComponent.self)?.dogWasCatched()
    }
}
