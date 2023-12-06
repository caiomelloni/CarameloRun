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
    var canMove: Bool = true
    private var isJoystickInUse: Bool = false
    private var joystickDirection: Direction = .left
    
    init(_ velocity: Double) {
        self.velocity = velocity
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addVelocity(_ direction: Direction) {
        
        if canMove {
            entity?.component(ofType: PlayerAnimationComponent.self)?.isRunning()
            let spriteComponent = entity?.component(ofType: SpriteComponent.self)
            let directionComponent = entity?.component(ofType: DirectionComponent.self)
            switch direction {
            case .right:
                entity?.component(ofType: SpriteComponent.self)?.dx = velocity
                directionComponent?.changeDirection(.right)
            case .left:
                entity?.component(ofType: SpriteComponent.self)?.dx = -1 * velocity
                directionComponent?.changeDirection(.left)
            }
        }
        
    }
    
    func stop() {
        let spriteComp = entity?.component(ofType: SpriteComponent.self)
        let dy = spriteComp?.dy
        if(dy == 0){
            entity?.component(ofType: PlayerAnimationComponent.self)?.idle()
            spriteComp?.dx = 0
        }
    }

    
    override func update(deltaTime seconds: TimeInterval) {
        if isJoystickInUse {
            addVelocity(joystickDirection)
        } else {
            stop()
        }
    }
    
}

extension VelocityComponent: GetNotifiedWhenJoystickStateChanges {
    func joystickStateChanged(inUse: Bool, direction: Direction) {
        isJoystickInUse = inUse
        joystickDirection = direction
    }
}
