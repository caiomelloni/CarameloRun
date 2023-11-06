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
            IdleState(spriteComponent,
                      statePrefix: Constants.playerFramesPrefix,
                      frameCount: Constants.playerIdleFramesCount),
            
            JumpingState(spriteComponent,
                         statePrefix: Constants.playerFramesPrefix,
                         frameCount: Constants.playerJumpFramesCount),
            
            FallingState(spriteComponent,
                         statePrefix: Constants.playerFramesPrefix,
                         frameCount: Constants.playerFallFramesCount),
            
            RunningState(spriteComponent,
                         statePrefix: Constants.playerFramesPrefix,
                         frameCount: Constants.playerRunFramesCount)
        ])
    }
}
