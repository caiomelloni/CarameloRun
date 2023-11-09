//
//  PositionHistory.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 25/10/23.
//
import Foundation

class PositionHistory {
    var oldX: CGFloat = 0
    var oldY: CGFloat = 0
    var oldState: String?
    
    func setReferencePosition(_ player: Player) {
        let playerPosition = player.component(ofType: SpriteComponent.self)!.position
        oldX = playerPosition.x
        oldY = playerPosition.y
        oldState = (player.component(ofType: PlayerAnimationComponent.self)?.stateMachine.currentState as? CodableState)?.stringIdentifier
    }
    
    func hasPositionChanged(_ player: Player) -> Bool {
        let playerPosition = player.component(ofType: SpriteComponent.self)!.position
        let currentState = (player.component(ofType: PlayerAnimationComponent.self)?.stateMachine.currentState as? CodableState)?.stringIdentifier
        let hasChanged = oldX != playerPosition.x || oldY != playerPosition.y || currentState != oldState
        oldX = playerPosition.x
        oldY = playerPosition.y
        oldState = currentState

        
        return hasChanged
    }
}
