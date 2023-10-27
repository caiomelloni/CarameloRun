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
    
    func setReferencePosition(_ player: Player) {
        let playerPosition = player.component(ofType: SpriteComponent.self)!.position
        oldX = playerPosition.x
        oldY = playerPosition.y
    }
    
    func hasPositionChanged(_ player: Player) -> Bool {
        let playerPosition = player.component(ofType: SpriteComponent.self)!.position
        let hasChanged = oldX != playerPosition.x || oldY != playerPosition.y
        oldX = playerPosition.x
        oldY = playerPosition.y
        
        return hasChanged
    }
}
