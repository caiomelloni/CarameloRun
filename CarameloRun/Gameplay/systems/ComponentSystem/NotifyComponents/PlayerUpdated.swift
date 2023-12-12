//
//  ComponentSystemExtension.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 29/11/23.
//

import GameplayKit

extension ComponentSystem {
    func notifyPlayerUpdate(_ localPlayer: GKEntity, _ remotePlayers: [GKEntity], _ updatedPlayer: GKEntity) {
        for comp in components(ofType: GetNotifiedWhenRemotePlayerUpdates.self) {
            comp.playerUpdated(localPlayer, remotePlayers, updatedPlayer)
        }
    }
    
}

protocol GetNotifiedWhenRemotePlayerUpdates {
    func playerUpdated(_ localPlayer: GKEntity, _ remotePlayers: [GKEntity], _ updatedPlayer: GKEntity)
}
