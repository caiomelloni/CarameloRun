//
//  RunningState.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 29/10/23.
//

import GameplayKit

class RunningState: GKState {
    
    let spriteComponent: SpriteComponent
    let spriteSheet = [
        SKTexture(imageNamed: "Run1"),
        SKTexture(imageNamed: "Run2"),
        SKTexture(imageNamed: "Run3"),
        SKTexture(imageNamed: "Run4"),
        SKTexture(imageNamed: "Run5"),
        SKTexture(imageNamed: "Run6"),
        SKTexture(imageNamed: "Run7"),
        SKTexture(imageNamed: "Run8"),
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
        return !(stateClass is RunningState.Type)
    }
    
    override func willExit(to nextState: GKState) {
        // performs action when exiting this state
    }
    
    override func update(deltaTime seconds: TimeInterval) {
    }
}
