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
        print("player \(player.displayName) pegou")
        
        // TODO: associar o estado dos outros jogadores | por enquanto a finalizacao do jogo nao funciona quando todos foram presos
        //if all players are arrested, them ends the game
        var allPlayersArrested = true
        for player in allRemotePlayers.values {
            if !(player.component(ofType: GetCaughtComponent.self)?.isArrested ?? false) {
                allPlayersArrested = false
                break
            }
        }
        
        if allPlayersArrested {
            finishGame?()
        }
        
        //TODO: add score to the catcher
    }
}
