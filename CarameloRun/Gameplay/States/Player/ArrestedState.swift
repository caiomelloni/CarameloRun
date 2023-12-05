//
//  ArrestedState.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 08/11/23.
//

import GameplayKit

class ArrestedState: GKState {
    let spriteComponent: SpriteComponent
    var spriteSheet: [SKTexture] = []
    
    init(_ spriteComponent: SpriteComponent, statePrefix: String, frameCount: Int) {
        for i in 1...frameCount {
            spriteSheet.append(SKTexture(imageNamed: "\(statePrefix)Arrested\(i)"))
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
        
        return !(stateClass is ArrestedState.Type || stateClass is FallingState.Type || stateClass is JumpingState.Type)
    }
    
    override func willExit(to nextState: GKState) {
        // performs action when exiting this state
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
    }
}
extension ArrestedState: CodableState {
    var stringIdentifier: String {
        StateType.arrestState.rawValue
    }
}
