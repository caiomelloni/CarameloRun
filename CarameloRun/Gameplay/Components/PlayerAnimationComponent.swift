//
//  SpriteAnimationComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 27/10/23.
//

import SpriteKit
import GameplayKit

// The entity must have a SpriteComponent to work
// And a state machine with the states: Idle, Jumping, falling, running
class PlayerAnimationComponent: GKComponent {
    
    let stateMachine: GKStateMachine
    var canChange: Bool = true
    
    init(_ stateMachine: GKStateMachine) {
        self.stateMachine = stateMachine
        self.stateMachine.enter(IdleState.self)
        super.init()
    }
    
    func isRunning() {
        if canChange {
            stateMachine.enter(RunningState.self)
        }
    }
    
    func idle() {
        if canChange {
            stateMachine.enter(IdleState.self)
        }
    }
    
    func jump() {
        if canChange {
            stateMachine.enter(JumpingState.self)
        }
    }
    
    func fall() {
        if canChange {
            stateMachine.enter(FallingState.self)
        }
    }
    
    func arrest() {
            stateMachine.enter(ArrestedState.self)
    }
    
    func dead() {
        canChange = false
        stateMachine.enter(DeadState.self)
        entity?.component(ofType: SpriteComponent.self)?.removeFromParent()

    }
    
    func winner() {
        if canChange {
            stateMachine.enter(WinnerState.self)
            entity?.component(ofType: SpriteComponent.self)?.removeFromParent()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        stateMachine.currentState?.update(deltaTime: seconds)
    }
    
}
