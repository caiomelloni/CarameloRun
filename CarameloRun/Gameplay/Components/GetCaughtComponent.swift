//
//  GetCaughtComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 07/11/23.
//

import GameplayKit

class GetCaughtComponent: GKComponent {
    var isArrested: Bool = false
    
    func gotCaught(_ respawn: CGPoint) {
        print("player foi pego")
        if !isArrested {
            isArrested = true
            entity?.component(ofType: SpriteComponent.self)?.position = respawn
            entity?.component(ofType: HealthComponent.self)?.decreaseLife()
            
            
            // removes player movement
            entity?.removeComponent(ofType: VelocityComponent.self)
            entity?.removeComponent(ofType: JumpComponent.self)
            
            // must be called after lose velocity end jump components
            entity?.component(ofType: PlayerAnimationComponent.self)?.arrest()

        }
        entity?.component(ofType: ScoreComponent.self)?.dogWasCatched()

    }
    
    func gotFreed() {
        isArrested = false
        
        entity?.component(ofType: PlayerAnimationComponent.self)?.idle()
        
        // adds player movement
        entity?.addComponent(VelocityComponent(Constants.playerVelocity))
        entity?.addComponent(JumpComponent(Constants.playerJumpXMultiplier, Constants.playerJumpYMultiplier))
    }
}
