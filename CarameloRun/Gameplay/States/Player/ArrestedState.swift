//
//  ArrestedState.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 08/11/23.
//

import GameplayKit

class ArrestedState: PlayerState {

    init(_ entity: GKEntity, statePrefix: String, frameCount: Int) {
        super.init(entity, statePrefix: statePrefix, frameCount: frameCount, stateType: StateType.arrestState)
    }
    
    override func didEnter(from previousState: GKState?) {
        // runs as it enters this state
        // has access to the previous state
        spriteComponent.run(.repeatForever(.animate(with: spriteSheet, timePerFrame: 0.1)))
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        // returns true if can go to the next state
        let isArrested = entity.component(ofType: GetCaughtComponent.self)?.isArrested ?? true
        
        // remote players can change its state inconditionally
        // because its state is represented by the player data that is send
        let isRemotePlayer = (entity as? RemotePlayer) != nil
        
        return !(isArrested) || isRemotePlayer
    }
    
    override func willExit(to nextState: GKState) {
        // performs action when exiting this state
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
    }
}
