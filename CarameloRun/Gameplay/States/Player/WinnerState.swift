//
//  DeadState.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 09/11/23.
//

import GameplayKit

class WinnerState: PlayerState {

    init(_ entity: GKEntity, statePrefix: String, frameCount: Int) {
        super.init(entity, statePrefix: statePrefix, frameCount: frameCount, stateType: StateType.winnerState)
    }
    
    override func didEnter(from previousState: GKState?) {
        // runs as it enters this state
        // has access to the previous state
        // spriteComponent?.run(.animate(with: spriteSheet, timePerFrame: 0.1))
        spriteComponent.removeFromParent()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        // returns true if can go to the next state
        
        return false
    }
    
    override func willExit(to nextState: GKState) {
        // performs action when exiting this state
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
    }
}
