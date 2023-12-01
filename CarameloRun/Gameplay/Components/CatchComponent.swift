//
//  CatchComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 06/11/23.
//

import Foundation
import GameplayKit

class CatchComponent: GKComponent {
    func didCollideWithPlayer(_ player: Player, _ allRemotePlayers: [Int:Player], finishGame: (() -> Void)?) {
        
        //TODO: add score to the catcher
        if (player.component(ofType: PlayerAnimationComponent.self)?.stateMachine.currentState as? ArrestedState) == nil {
            entity?.component(ofType: ScoreComponent.self)?.humanCatch()
        }
        
        player.component(ofType: PlayerAnimationComponent.self)?.stateMachine.enter(ArrestedState.self)
        
        // TODO: associar o estado dos outros jogadores | por enquanto a finalizacao do jogo nao funciona quando todos foram presos
        // if all players are arrested, them ends the game
        var allPlayersCaught = true
        var hasDogWinner = false
        for player in allRemotePlayers.values {
            let state = player.component(ofType: PlayerAnimationComponent.self)?.stateMachine.currentState as! CodableState
            let currentPlayerState = PlayerStateStringIdentifier(rawValue: state.stringIdentifier)
            if  currentPlayerState != .arrestState && currentPlayerState != .deadState && currentPlayerState != .winnerState{
                allPlayersCaught = false
                break
            } else if currentPlayerState == .winnerState {
                hasDogWinner = true
            }
        }
        
        if allPlayersCaught {
            if !hasDogWinner {
                entity?.component(ofType: ScoreComponent.self)?.humanCatchAllDogs()
            }
            finishGame?()
        }
        
        
    }
}
