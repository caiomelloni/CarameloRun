//
//  HandlePlayersExtension.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 31/10/23.
//

import SpriteKit
import GameKit

// functions that deals with players
extension GameScene {
    func placePlayersInitialPositionInMap() {
        let players = controllerDelegate?.players
        
        guard let players = players else {
            //TODO: treat errors in a better way
            print("ERROR: NULL PLAYERS")
            return
        }
        
        entityManager.initPlayersEntities(lobbyPlayers: players)
    }

    
    func removeJoystickAndJumpButton() {
        joystick.removeFromScene()
        jumpButton.removeFromScene()
    }
    
}
