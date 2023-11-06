//
//  GameCenterCommunicationExtension.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 31/10/23.
//

import GameKit

extension GameScene {
    func updatePlayerPositionForOtherPlayers() {
        if localPlayerPositionHistory.hasPositionChanged(localPlayer!) {
            let playerState = PlayerState(name: GKLocalPlayer.local.displayName,
                                          playerNumber: localPlayer.playerNumber,
                                          positionX: localPlayer.component(ofType: SpriteComponent.self)!.position.x,
                                          positionY: localPlayer.component(ofType: SpriteComponent.self)!.position.y)
            
            controllerDelegate?.sendPlayerState(playerState)
        }
    }
    
}