//
//  PlayerStateMachine.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 30/10/23.
//

import GameplayKit

class PlayerStateMachine: GKStateMachine {
    
    init(_ spriteComponent: SpriteComponent) {
        super.init(states:  [
            IdleState(spriteComponent),
            JumpingState(spriteComponent),
            FallingState(spriteComponent),
            RunningState(spriteComponent)
        ])
    }
}
