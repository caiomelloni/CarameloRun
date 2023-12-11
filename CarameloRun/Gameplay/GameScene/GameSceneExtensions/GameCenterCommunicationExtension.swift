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
    
    func playerDisconnected(_ playerName: String) {
        for player in entityManager.remotePlayers {
            if player.displayName == playerName {
                if player.type == .man {
                    //TODO: Implement better feedback to the user. For instance, say that the catcher disconnected
                    controllerDelegate?.finishGame()
                } else {
                    entityManager.updateRemotePlayerPosition(PlayerData(name: player.displayName, playerNumber: player.playerNumber, positionX: 0, positionY: 0, state: StateType.deadState.rawValue))
                }
            }
        }
    }
}
