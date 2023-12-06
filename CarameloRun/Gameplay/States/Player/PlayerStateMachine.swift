//
//  PlayerStateMachine.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 30/10/23.
//

import GameplayKit

class PlayerStateMachine: GKStateMachine {
    
    init(_ entity: GKEntity) {
        super.init(states:  [
            IdleState(entity,
                      statePrefix: Constants.playerFramesPrefix,
                      frameCount: Constants.playerIdleFramesCount),
            
            JumpingState(entity,
                         statePrefix: Constants.playerFramesPrefix,
                         frameCount: Constants.playerJumpFramesCount),
            
            FallingState(entity,
                         statePrefix: Constants.playerFramesPrefix,
                         frameCount: Constants.playerFallFramesCount),
            
            RunningState(entity,
                         statePrefix: Constants.playerFramesPrefix,
                         frameCount: Constants.playerRunFramesCount),
            
            ArrestedState(entity, 
                          statePrefix: Constants.playerFramesPrefix,
                          frameCount: Constants.playerArrestedFramesCount),
            DeadState(entity,
                      statePrefix: Constants.playerFramesPrefix,
                      frameCount: Constants.playerArrestedFramesCount)
        ])
    }
}
