//
//  GameCenterCommunicationExtension.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 31/10/23.
//

import GameKit

extension GameScene {
    func updatePlayerPositionForOtherPlayers() {
        if localPlayerPositionHistory.hasPositionChanged(dog!) {
            let playerState = PlayerState(name: GKLocalPlayer.local.displayName,
                                          playerNumber: dog.playerNumber,
                                          positionX: dog.component(ofType: SpriteComponent.self)!.position.x,
                                          positionY: dog.component(ofType: SpriteComponent.self)!.position.y)
            
            controllerDelegate?.sendPlayerState(playerState)
        }
    }
    
}
