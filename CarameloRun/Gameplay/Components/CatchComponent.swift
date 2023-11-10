//
//  CatchComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 06/11/23.
//

import Foundation
import GameplayKit

class CatchComponent: GKComponent {
    func didCollideWithPlayer(_ player: Player, _ allRemotePlayers: [Int:Player], finishGame: (() -> Void)?) async {
        try? await Task.sleep(nanoseconds: 2_000_000_000) // waits for player state update
        
        // TODO: associar o estado dos outros jogadores | por enquanto a finalizacao do jogo nao funciona quando todos foram presos
        // if all players are arrested, them ends the game
        var allPlayersArrested = true
        for player in allRemotePlayers.values {
            let state = player.component(ofType: PlayerAnimationComponent.self)?.stateMachine.currentState as! CodableState
            if  PlayerStateStringIdentifier(rawValue: state.stringIdentifier) != .arrestState {
                allPlayersArrested = false
                break
            }
        }
        
        if allPlayersArrested {
            finishGame?()
        }
        
        //TODO: add score to the catcher
        entity?.component(ofType: ScoreComponent.self)?.humanCatch()
    }
}
