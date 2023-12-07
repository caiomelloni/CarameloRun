//
//  GameCenterCommunicationExtension.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 31/10/23.
//

import GameKit

extension GameScene {
    func didReceiveData(_ match: GKMatch, _ jsonData: Data, _ fromRemotePlayer: GKPlayer) {
        if let playerData = try? JSONDecoder().decode(PlayerData.self, from: jsonData) {
            entityManager.updateRemotePlayerPosition(playerData)
        }
        
        if let matchState = try? JSONDecoder().decode(MatchState.self, from: jsonData) {
            if matchState.finish {
                controllerDelegate?.finishGame()
            }
        }
    }
}
