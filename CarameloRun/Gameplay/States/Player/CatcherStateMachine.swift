//
//  CatcherStateMachine.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 01/11/23.
//

import GameplayKit

class CatcherStateMachine: GKStateMachine {
    
    init(_ entity: GKEntity) {
        super.init(states:  [
            IdleState(entity,
                      statePrefix: Constants.catcherFramesPrefix,
                      frameCount: Constants.catcherIdleFramesCount),
            
            JumpingState(entity,
                         statePrefix: Constants.catcherFramesPrefix,
                         frameCount: Constants.catcherJumpFramesCount),
            
            FallingState(entity,
                         statePrefix: Constants.catcherFramesPrefix,
                         frameCount: Constants.catcherFallFramesCount),
            
            RunningState(entity,
                         statePrefix: Constants.catcherFramesPrefix,
                         frameCount: Constants.catcherRunFramesCount)
        ])
    }
}
