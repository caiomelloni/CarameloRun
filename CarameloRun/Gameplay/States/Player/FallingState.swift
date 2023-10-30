//
//  FallingState.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 29/10/23.
//

import GameplayKit

class FallingState: GKState {
    
    let spriteComponent: SpriteComponent
    let spriteSheet = [
        SKTexture(imageNamed: "Fall1"),
        SKTexture(imageNamed: "Fall2")
    ]
    
    init(_ spriteComponent: SpriteComponent) {
        self.spriteComponent = spriteComponent
    }
    
    override func didEnter(from previousState: GKState?) {
        // runs as it enters this state
        // has access to the previous state
        spriteComponent.run(.animate(with: spriteSheet, timePerFrame: 1))
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        // returns true if can go to the next state
        return !(stateClass is FallingState.Type)
    }
    
    override func willExit(to nextState: GKState) {
        // performs action when exiting this state
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
    }
}
