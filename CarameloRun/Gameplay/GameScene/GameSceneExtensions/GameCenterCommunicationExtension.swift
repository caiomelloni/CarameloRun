//
//  GameCenterCommunicationExtension.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 31/10/23.
//

import GameKit

extension GameScene {
    func updatePlayerPositionForOtherPlayers() {
        let localPlayer = entityManager.localPlayer!
        if localPlayerPositionHistory.hasPositionChanged(localPlayer) {
            let playerState = PlayerState(name: GKLocalPlayer.local.displayName,
                                          playerNumber: localPlayer.playerNumber,
                                          positionX: localPlayer.component(ofType: SpriteComponent.self)!.position.x,
                                          positionY: localPlayer.component(ofType: SpriteComponent.self)!.position.y,
                                          state: (localPlayer.component(ofType: PlayerAnimationComponent.self)?.stateMachine.currentState as? CodableState)?.stringIdentifier ?? PlayerStateStringIdentifier.deadState.rawValue)
            
            controllerDelegate?.sendPlayerState(playerState)
        }
    }
    
}
