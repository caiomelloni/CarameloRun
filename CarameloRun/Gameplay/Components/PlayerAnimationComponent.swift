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
    
    init(_ stateMachine: GKStateMachine) {
        self.stateMachine = stateMachine
        self.stateMachine.enter(IdleState.self)
        super.init()
    }
    
    func run() {
        stateMachine.enter(RunningState.self)
    }
    
    func idle() {
        stateMachine.enter(IdleState.self)
    }
    
    func jump() {
        stateMachine.enter(JumpingState.self)
    }
    
    func fall() {
        stateMachine.enter(FallingState.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        stateMachine.currentState?.update(deltaTime: seconds)
    }
    
}
