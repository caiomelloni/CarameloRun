//
//  CatchComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 06/11/23.
//

import Foundation
import GameplayKit

class CatchComponent: GKComponent {
    var allRemotePlayers: (() -> [RemotePlayer]?)?
    var finishGame: (()->Void)?
    
    func finishGameIfAllPlayersWereCaught() {
        guard let allRemotePlayers = allRemotePlayers?() else {
            fatalError("ERROR: CatchComponent does not have a reference to remote players")
        }
        
        // TODO: associar o estado dos outros jogadores | por enquanto a finalizacao do jogo nao funciona quando todos foram presos
        // if all players are arrested, them ends the game
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

extension CatchComponent: GetNotifiedWhenContactHappens {
    func didBegin(_ contact: SKPhysicsContact) {
        let contactedEntities = [contact.bodyA.node?.entity, contact.bodyB.node?.entity]
        
        let wasMyEntityContacted = contactedEntities.contains(where: {$0 == entity})
        
        if !wasMyEntityContacted {
            return
        }
        
        for contactEntity in contactedEntities {
            let entityType = (contactEntity as? RemotePlayer)?.type
            
            let entityIsADog = entityType == .dog
            
            if  entityIsADog {
//               didCollideWithPlayer()
            }
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {

    }
    
    
}
