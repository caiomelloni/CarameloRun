//
//  CatcherStateMachine.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 01/11/23.
//

import GameplayKit

class CatcherStateMachine: GKStateMachine {
    
    init(_ spriteComponent: SpriteComponent) {
        super.init(states:  [
            IdleState(spriteComponent,
                      statePrefix: Constants.catcherFramesPrefix,
                      frameCount: Constants.catcherIdleFramesCount),
            
            JumpingState(spriteComponent,
                         statePrefix: Constants.catcherFramesPrefix,
                         frameCount: Constants.catcherJumpFramesCount),
            
            FallingState(spriteComponent,
                         statePrefix: Constants.catcherFramesPrefix,
                         frameCount: Constants.catcherFallFramesCount),
            
            RunningState(spriteComponent,
                         statePrefix: Constants.catcherFramesPrefix,
                         frameCount: Constants.catcherRunFramesCount)
        ])
    }
}
