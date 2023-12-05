//
//  GameCenterCommunicationExtension.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 31/10/23.
//

import GameKit

extension GameScene {
    func didReceiveData(_ match: GKMatch, _ jsonData: Data, _ fromRemotePlayer: GKPlayer) {
        if let playerState = try? JSONDecoder().decode(PlayerState.self, from: jsonData) {
            entityManager.updateRemotePlayerPosition(playerState)
            if entityManager.localPlayer?.type == .man {
                entityManager.localPlayer?.component(ofType: CatchComponent.self)?.finishGameIfAllPlayersWereCaught()
            }
        }
        
        if let finishGameMessage = try? JSONDecoder().decode(MatchState.self, from: jsonData) {
            if finishGameMessage.finish {
                controllerDelegate?.finishGame()
            }
        }
    }
}
