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
        oldX = player.position.x
        oldY = player.position.y
    }
    
    func hasPositionChanged(_ player: Player) -> Bool {
        let hasChanged = oldX != player.position.x || oldY != player.position.y
        oldX = player.position.x
        oldY = player.position.y
        
        return hasChanged
    }
}
