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
            //TODO: restringir movimentos e mudar o estado para preso
            
            // removes player movement
            entity?.removeComponent(ofType: VelocityComponent.self)
            entity?.removeComponent(ofType: JumpComponent.self)
            
        }
    }
    
    func gotFreed() {
        isArrested = false
        //TODO: recuperar movientos e sair do estado de preso
        
        // adds player movement
        entity?.addComponent(VelocityComponent(Constants.playerVelocity))
        entity?.addComponent(JumpComponent(Constants.playerJumpXMultiplier, Constants.playerJumpYMultiplier))
    }
}
