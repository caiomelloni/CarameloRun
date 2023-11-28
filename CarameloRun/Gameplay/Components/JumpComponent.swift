//
//  JumpComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 27/10/23.
//

import SpriteKit
import GameplayKit

// Apply jump: Must have SpriteComponent and DirectionComponent to work properly
class JumpComponent: GKComponent {
    let jumpXMultiplyer: Double
    let jumpYMultiplyer: Double
    init(_ jumpXMultiplyer: Double,_ jumpYMultiplyer: Double) {
        self.jumpXMultiplyer = jumpXMultiplyer
        self.jumpYMultiplyer = jumpYMultiplyer
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func jump() {
        if let spritComponent = entity?.component(ofType: SpriteComponent.self), let directionComponent = entity?.component(ofType: DirectionComponent.self) {
            if spritComponent.physicsBody?.velocity.dy != 0 {
                return
            }
            var direction = 1.00
            if directionComponent.direction == .left {
                direction = -1
            }
            spritComponent.physicsBody?.applyImpulse(
                .init(dx: direction * jumpXMultiplyer, dy: jumpYMultiplyer)
            )
        }

    }
    
    override func update(deltaTime seconds: TimeInterval) {
        let dy = entity?.component(ofType: SpriteComponent.self)?.dy
        let animationComponent = entity?.component(ofType: PlayerAnimationComponent.self)
        if let dy = dy {
            if dy > 0 {
                animationComponent?.jump()
            } else if dy < 0 {
                animationComponent?.fall()
            }
        }
    }
}
