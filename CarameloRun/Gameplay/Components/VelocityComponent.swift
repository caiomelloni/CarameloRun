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
        
        entity?.component(ofType: PlayerStateComponent.self)?.enterRunState()
        let spriteComponent = entity?.component(ofType: SpriteComponent.self)
        let directionComponent = entity?.component(ofType: DirectionComponent.self)
        switch direction {
        case .right:
            spriteComponent?.dx = velocity
            directionComponent?.changeDirection(.right)
        case .left:
            spriteComponent?.dx = -1 * velocity
            directionComponent?.changeDirection(.left)
        }
        
    }
    
    func stop() {
        let spriteComp = entity?.component(ofType: SpriteComponent.self)
        let dy = spriteComp?.dy
        if(dy == 0){
            entity?.component(ofType: PlayerStateComponent.self)?.enterIdleState()
            spriteComp?.dx = 0
        }
    }

    
    override func update(deltaTime seconds: TimeInterval) {
        let currentState = entity?.component(ofType: PlayerStateComponent.self)?.currentStateType
        if currentState == .arrestState || currentState == .deadState || currentState == .winnerState {
            return
        }
        
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
