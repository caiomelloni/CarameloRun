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
        if !isArrested {
            isArrested = true
            entity?.component(ofType: PlayerAnimationComponent.self)?.canChange = false
            entity?.component(ofType: SpriteComponent.self)?.position = respawn
            
            entity?.component(ofType: ScoreComponent.self)?.dogWasCatched()
            
            // removes player movement
            entity?.component(ofType: JumpComponent.self)?.canJump = false
            entity?.component(ofType: VelocityComponent.self)?.canMove = false
            
            // must be called after lose velocity end jump components
            let healthPoints = entity?.component(ofType: HealthComponent.self)?.decreaseLife()
            let animationComponent = entity?.component(ofType: PlayerAnimationComponent.self)
            if healthPoints == 0 {
                animationComponent?.dead()
            } else {
                animationComponent?.arrest()
            }
        }
    }
    
    func gotFreed() {
        isArrested = false
        entity?.component(ofType: PlayerAnimationComponent.self)?.canChange = true
        entity?.component(ofType: PlayerAnimationComponent.self)?.idle()
        
        // adds player movement
        entity?.component(ofType: JumpComponent.self)?.canJump = true
        entity?.component(ofType: VelocityComponent.self)?.canMove = true
    }
}
