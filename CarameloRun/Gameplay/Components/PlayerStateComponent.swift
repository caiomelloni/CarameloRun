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
    private var oldStateStringIdentifier: String = PlayerStateStringIdentifier.idleState.rawValue
    private var currentStateStringIdentifier: String = PlayerStateStringIdentifier.idleState.rawValue
    
    var currentStateType = StateType.idle
    
    init(_ stateMachine: GKStateMachine) {
        self.stateMachine = stateMachine
        self.stateMachine.enter(IdleState.self)
        super.init()
    }
    
    func run() {
        stateMachine.enter(RunningState.self)
        currentStateType = .run
    }
    
    func idle() {
        stateMachine.enter(IdleState.self)
        currentStateType = .idle
    }
    
    func jump() {
        stateMachine.enter(JumpingState.self)
        currentStateType = .jump
    }
    
    func fall() {
        stateMachine.enter(FallingState.self)
        currentStateType = .fall
    }
    
    func arrest() {
        stateMachine.enter(ArrestedState.self)
        currentStateType = .arrest
    }
    
    func dead() {
        stateMachine.enter(DeadState.self)
        entity?.component(ofType: SpriteComponent.self)?.removeFromParent()
        currentStateType = .dead
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        currentStateStringIdentifier = getCurrentStateStringIdentifier()
        stateMachine.currentState?.update(deltaTime: seconds)
    }
    
    func hasStateChanged() -> Bool {
        let hasChanged = oldStateStringIdentifier != currentStateStringIdentifier
        oldStateStringIdentifier = currentStateStringIdentifier
        return hasChanged
    }
    
    private func getCurrentStateStringIdentifier() -> String {
        return (stateMachine.currentState as? CodableState)?.stringIdentifier ?? PlayerStateStringIdentifier.idleState.rawValue
    }
    
}

enum StateType {
    case run
    case idle
    case jump
    case fall
    case arrest
    case dead
}
