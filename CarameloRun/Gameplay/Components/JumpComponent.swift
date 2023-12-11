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
        guard let stateComponent = entity?.component(ofType: PlayerStateComponent.self) else {
            fatalError("ERROR: PlayerStateComponent was nil when jump button was pressed")
        }

        let currentState = stateComponent.currentStateType
        if currentState == .arrestState || currentState == .deadState {
            return
        }
        
        
        if let spritComponent = entity?.component(ofType: SpriteComponent.self) {
            if spritComponent.physicsBody?.velocity.dy != 0 {
                return
            }

            spritComponent.physicsBody?.applyImpulse(
                .init(dx: 0, dy: jumpYMultiplyer)
            )
        }

    }
    
    override func update(deltaTime seconds: TimeInterval) {
        guard let stateComponent = entity?.component(ofType: PlayerStateComponent.self) else {
            fatalError("ERROR: PlayerStateComponent was nil when jump button was pressed")
        }

        let currentState = stateComponent.currentStateType
        if currentState == .arrestState || currentState == .deadState {
            return
        }
        
        let dy = entity?.component(ofType: SpriteComponent.self)?.dy
        if let dy = dy {
            if dy > 0 {
                stateComponent.enterJumpState()
            } else if dy < 0 {
                stateComponent.enterFallState()
            }
        }
    }
}

extension JumpComponent: GetNotifiedWhenJumpButtonIsPressed {
    func jumpButtonPressed() {
        jump()
    }
}
