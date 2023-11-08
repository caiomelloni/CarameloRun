//
//  VelocityComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 27/10/23.
//

import SpriteKit
import GameplayKit

// Adds velocity to a entity that has a SpriteComponent
class VelocityComponent: GKComponent {
    let velocity: Double
    
    init(_ velocity: Double) {
        self.velocity = velocity
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addVelocity(_ direction: Direction) {
        entity?.component(ofType: PlayerAnimationComponent.self)?.run()
        let spriteComponent = entity?.component(ofType: SpriteComponent.self)
        let directionComponent = entity?.component(ofType: DirectionComponent.self)
        switch direction {
        case .right:
            spriteComponent?.position.x += velocity
            directionComponent?.changeDirection(.right)
        case .left:
            spriteComponent?.position.x -= velocity
            directionComponent?.changeDirection(.left)
        }
        
    }
    
    func stop() {
        let dy = entity?.component(ofType: SpriteComponent.self)?.dy
        if(dy == 0){
            entity?.component(ofType: PlayerAnimationComponent.self)?.idle()
        }
    }
    
}
