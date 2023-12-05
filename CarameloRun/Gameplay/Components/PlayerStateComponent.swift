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
class PlayerStateComponent: GKComponent {
    
    let stateMachine: GKStateMachine
    
    var currentStateType = StateType.idleState
    private var oldStateType = StateType.idleState
    
    init(_ stateMachine: GKStateMachine) {
        self.stateMachine = stateMachine
        self.stateMachine.enter(IdleState.self)
        super.init()
    }
    
    func enterRunState() {
        stateMachine.enter(RunningState.self)
        currentStateType = .runState
    }
    
    func enterIdleState() {
        stateMachine.enter(IdleState.self)
        currentStateType = .idleState
    }
    
    func enterJumpState() {
        stateMachine.enter(JumpingState.self)
        currentStateType = .jumpState
    }
    
    func enterFallState() {
        stateMachine.enter(FallingState.self)
        currentStateType = .fallState
    }
    
    func enterArrestState() {
        stateMachine.enter(ArrestedState.self)
        currentStateType = .arrestState
    }
    
    func enterDeadState() {
        stateMachine.enter(DeadState.self)
        currentStateType = .deadState
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        stateMachine.currentState?.update(deltaTime: seconds)
    }
    
    func hasStateChanged() -> Bool {
        let hasChanged = oldStateType != currentStateType
        oldStateType = currentStateType
        return hasChanged
    }
    
}

enum StateType: String {
    case runState = "runState"
    case idleState = "idleState"
    case jumpState = "jumpState"
    case fallState = "fallState"
    case arrestState = "arrestState"
    case deadState = "deadState"
}
