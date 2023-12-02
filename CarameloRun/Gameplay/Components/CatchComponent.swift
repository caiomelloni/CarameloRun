//
//  CatchComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 06/11/23.
//

import Foundation
import GameplayKit

class CatchComponent: GKComponent {
    func didCollideWithPlayer(_ player: RemotePlayer, _ allRemotePlayers: [RemotePlayer], finishGame: (() -> Void)?) {
        
        // TODO: associar o estado dos outros jogadores | por enquanto a finalizacao do jogo nao funciona quando todos foram presos
        // if all players are arrested, them ends the game
        var allPlayersCaught = true
        for player in allRemotePlayers {
            print(player.component(ofType: PlayerStateComponent.self)?.currentStateType)
            let state = player.component(ofType: PlayerStateComponent.self)?.stateMachine.currentState as! CodableState
            let currentPlayerState = PlayerStateStringIdentifier(rawValue: state.stringIdentifier)
            if  currentPlayerState != .arrestState && currentPlayerState != .deadState {
                allPlayersCaught = false
                break
            }
        }
        
        if allPlayersCaught {
            entity?.component(ofType: ScoreComponent.self)?.humanCatchAllDogs()
            
            finishGame?()
        }
        
        
    }
}

extension CatchComponent: GetNotifiedWhenContactHappens {
    func didBegin(_ contact: SKPhysicsContact) {
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
    }
    
    
}
