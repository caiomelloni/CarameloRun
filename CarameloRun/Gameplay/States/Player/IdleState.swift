//
//  IdleState.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 29/10/23.
//

import GameplayKit

class IdleState: GKState {
    
    let spriteComponent: SpriteComponent
    let spriteSheet = [
        SKTexture(imageNamed: "Idle1"),
        SKTexture(imageNamed: "Idle2"),
        SKTexture(imageNamed: "Idle3"),
        SKTexture(imageNamed: "Idle4"),
        SKTexture(imageNamed: "Idle5"),
        SKTexture(imageNamed: "Idle6"),
        SKTexture(imageNamed: "Idle7"),
        SKTexture(imageNamed: "Idle8"),
        SKTexture(imageNamed: "Idle9"),
    ]
    
    init(_ spriteComponent: SpriteComponent) {
        self.spriteComponent = spriteComponent
    }
    
    override func didEnter(from previousState: GKState?) {
        // runs as it enters this state
        // has access to the previous state
        spriteComponent.run(.repeatForever(.animate(with: spriteSheet, timePerFrame: 0.1)))
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        // returns true if can go to the next state
        
        return !(stateClass is IdleState.Type)
    }
    
    override func willExit(to nextState: GKState) {
        // performs action when exiting this state
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
    }
}
