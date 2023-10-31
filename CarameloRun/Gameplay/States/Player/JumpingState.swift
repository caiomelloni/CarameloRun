//
//  JumpState.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 29/10/23.
//

import GameplayKit

class JumpingState: GKState {
    
    let spriteComponent: SpriteComponent
    let spriteSheet = [
       SKTexture(imageNamed: "Jump1"),
       SKTexture(imageNamed: "Jump2"),
       SKTexture(imageNamed: "Jump3"),
       SKTexture(imageNamed: "Jump4"),
       SKTexture(imageNamed: "Jump5"),
       SKTexture(imageNamed: "Jump6"),
       SKTexture(imageNamed: "Jump7"),
       SKTexture(imageNamed: "Jump8"),
       SKTexture(imageNamed: "Jump9"),
       SKTexture(imageNamed: "Jump10")
    ]
    
    init(_ spriteComponent: SpriteComponent) {
        self.spriteComponent = spriteComponent
    }
    
    override func didEnter(from previousState: GKState?) {
        // runs as it enters this state
        // has access to the previous state
        spriteComponent.run(.animate(with: spriteSheet, timePerFrame: 0.1))
        print("did enter to jumping")
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        // returns true if can go to the next state
        return !(stateClass is JumpingState.Type)
    }
    
    override func willExit(to nextState: GKState) {
        // performs action when exiting this state
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
    }
}
