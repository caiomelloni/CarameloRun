//
//  WinnerState.swift
//  CarameloRun
//
//  Created by Luis Silva on 01/12/23.
//

import GameplayKit

class WinnerState: GKState {
    let spriteComponent: SpriteComponent?
    var spriteSheet: [SKTexture] = []
    
    init(_ spriteComponent: SpriteComponent, statePrefix: String, frameCount: Int) {
        for i in 1...frameCount {
            spriteSheet.append(SKTexture(imageNamed: "\(statePrefix)Winner\(i)"))
        }
        
        self.spriteComponent = spriteComponent
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        // returns true if can go to the next state
        
        return false
    }
}

extension WinnerState: CodableState {
    var stringIdentifier: String{
        PlayerStateStringIdentifier.winnerState.rawValue
    }
}
