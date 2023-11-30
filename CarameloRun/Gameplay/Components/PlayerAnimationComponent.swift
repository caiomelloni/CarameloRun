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
    private var oldStateStringIdentifier: String = PlayerStateStringIdentifier.idleState.rawValue
    private var currentStateStringIdentifier: String = PlayerStateStringIdentifier.idleState.rawValue
    
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
    
    func arrest() {
        stateMachine.enter(ArrestedState.self)
    }
    
    func dead() {
        stateMachine.enter(DeadState.self)
        entity?.component(ofType: SpriteComponent.self)?.removeFromParent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        oldStateStringIdentifier = currentStateStringIdentifier
        currentStateStringIdentifier = getCurrentStateStringIdentifier()
        stateMachine.currentState?.update(deltaTime: seconds)
    }
    
    func hasStateChanged() -> Bool {
       oldStateStringIdentifier != currentStateStringIdentifier
    }
    
    private func getCurrentStateStringIdentifier() -> String {
        return (stateMachine.currentState as? CodableState)?.stringIdentifier ?? PlayerStateStringIdentifier.idleState.rawValue
    }
    
}
