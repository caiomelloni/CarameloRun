//
//  HandlePlayersExtension.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 31/10/23.
//

import SpriteKit
import GameKit

// functions that deals with players
extension GameScene {
    func placePlayersInitialPositionInMap() {
        let players = controllerDelegate?.players
        
        
        if let players = players {
            for playerFromPreparing in players {
                
                //isso eh necessario porque a mesma classe eh usada para passar dados
                //da tela de PreparingViewController
                let player = Player(displayName: playerFromPreparing.displayName, playerNumber: playerFromPreparing.playerNumber, playerType: playerFromPreparing.type)
                
                let spawnNode = scene?.childNode(withName: "spawn\(player.playerNumber)")
                
                entityManager.addEntity(player, spawnPoint: spawnNode?.position)
                
                if player.displayName == GKLocalPlayer.local.displayName {
                    localPlayer = player
                    localPlayerPositionHistory.setReferencePosition(player)
                } else {
                    // TO DO: tirar gravidade e proibir que um player empurre o outro
                    // o no do player deve ser um ponto fixo no mapa, que se movimenta apenas pelas
                    // coordenadas emitidas
                    // player.component(ofType: SpriteComponent.self).affectedByGravity = false
                    remotePlayers[player.playerNumber] = player
                }
                
            }
        } else {
            print("ERROR: NULL PLAYERS")
        }
    }
    
    func updatePlayersPosition(_ playerState: PlayerState) {
        let newPosition = CGPoint(x: playerState.positionX, y: playerState.positionY)
        remotePlayers[playerState.playerNumber]?.component(ofType: SpriteComponent.self)?.position = newPosition
    }
}