//
//  CatchComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 06/11/23.
//

import Foundation
import GameplayKit

class CatchComponent: GKComponent {
    var finishGame: (()->Void)?
    
    func finishGameIfAllPlayersWereCaught(_ allRemotePlayers: [GKEntity]) {

        // if all players are in arrested/dead/winner state, ends the game
        var allPlayersCaught = true
        for player in allRemotePlayers {
            let state = player.component(ofType: PlayerStateComponent.self)?.currentStateType
            if  state != .arrestState && state != .deadState {
                allPlayersCaught = false
                break
            }
        }
        
        if allPlayersCaught {
            entity?.component(ofType: ScoreComponent.self)?.humanCatchAllDogs()
            
            guard let finishGame = finishGame else {
                fatalError("ERROR: CatchComponent does not have a reference to finish game function")
            }
            
            finishGame()
            entity?.component(ofType: SendPlayerUpdatesComponent.self)?.finishMatch()
        }
        
        
    }
}

extension CatchComponent: GetNotifiedWhenRemotePlayerUpdates {
    func playerUpdated(_ localPlayer: GKEntity, _ remotePlayers: [GKEntity], _ updatedPlayer: GKEntity) {
        finishGameIfAllPlayersWereCaught(remotePlayers)
    }
}
