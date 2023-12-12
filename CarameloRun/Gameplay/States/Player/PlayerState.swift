//
//  PlayerState.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 05/12/23.
//

import GameplayKit

class PlayerState: GKState {
    
    let entity: GKEntity
    var spriteSheet: [SKTexture] = []
    let spriteComponent: SpriteComponent
    let stringIdentifier: String
    
    init(_ entity: GKEntity, statePrefix: String, frameCount: Int, stateType: StateType) {
        for i in 1...frameCount {
            spriteSheet.append(SKTexture(imageNamed: "\(statePrefix)\(stateType.rawValue)\(i)"))
        }
        
        self.entity = entity
        guard let spriteComponent = entity.component(ofType: SpriteComponent.self) else {
            fatalError("ERROR: SpriteComponent was null when PlayerStateComponent was added")
        }
        self.spriteComponent = spriteComponent
        self.stringIdentifier = stateType.rawValue
    }
    
}
