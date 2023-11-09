//
//  DeadState.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 09/11/23.
//

import GameplayKit

class DeadState: GKState {
    let spriteComponent: SpriteComponent
    var spriteSheet: [SKTexture] = []
    
    init(_ spriteComponent: SpriteComponent, statePrefix: String, frameCount: Int) {
        for i in 1...frameCount {
            spriteSheet.append(SKTexture(imageNamed: "\(statePrefix)Dead\(i)"))
        }
        
        self.spriteComponent = spriteComponent
    }
    
    override func didEnter(from previousState: GKState?) {
        // runs as it enters this state
        // has access to the previous state
        spriteComponent.run(.repeatForever(.animate(with: spriteSheet, timePerFrame: 0.1)))
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        // returns true if can go to the next state
        
        return false
    }
    
    override func willExit(to nextState: GKState) {
        // performs action when exiting this state
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
    }
}

extension DeadState: CodableState {
    var stringIdentifier: String {
        PlayerStateStringIdentifier.deadState.rawValue
    }
}
