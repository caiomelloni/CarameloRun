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
                
                player.component(ofType: HealthComponent.self)?.killPlayerRef = killPlayer
            }
        } else {
            print("ERROR: NULL PLAYERS")
        }
    }
    
    func updatePlayersPosition(_ playerState: PlayerState) {
        let newPosition = CGPoint(x: playerState.positionX, y: playerState.positionY)
        let player = remotePlayers[playerState.playerNumber]
        let spriteComp = player?.component(ofType: SpriteComponent.self)
        
        let oldX = spriteComp?.position.x
        spriteComp?.position = newPosition
        
        let animationComp = player?.component(ofType: PlayerAnimationComponent.self)
        
        switch PlayerStateStringIdentifier(rawValue: playerState.state) {
        case .idleState:
            animationComp?.idle()
        case .runState:
            animationComp?.run()
        case .fallState:
            animationComp?.fall()
        case .jumpState:
            animationComp?.jump()
        case .arrestState:
            animationComp?.arrest()
        case .deadState:
            animationComp?.dead()
        default:
            print("=> func updatePlayerPosition: no state detected for the remote player")
        }
        
        // fixes player orientation
        let directionComp = player?.component(ofType: DirectionComponent.self)
        let dx = (oldX ?? 0) - newPosition.x
        if dx > 0 {
            directionComp?.changeDirection(.left)
        } else if dx < 0{
            directionComp?.changeDirection(.right)
        }
        
    }
    
    func handlePlayerCollision() {
        for remotePlayer in remotePlayers.values {
            if CGRectIntersectsRect(localPlayer.component(ofType: SpriteComponent.self)!.frame, remotePlayer.component(ofType: SpriteComponent.self)!.frame) {
                if remotePlayer.type == .man {
                    localPlayer.component(ofType: GetCaughtComponent.self)?.gotCaught(emptyRespawnPoint(localPlayer))
                } else {
                    localPlayer.component(ofType: GetCaughtComponent.self)?.gotFreed()
                }
                
                // just called by a catcher
                localPlayer.component(ofType: CatchComponent.self)?.didCollideWithPlayer(remotePlayer, remotePlayers, finishGame: controllerDelegate?.finishGame)
            }
        }
    }
    
    private func emptyRespawnPoint(_ player: Player) -> CGPoint {
        let respawns = [
            scene!.childNode(withName: "respawn1")!,
            scene!.childNode(withName: "respawn2")!,
            scene!.childNode(withName: "respawn3")!,
            scene!.childNode(withName: "respawn4")!,
            scene!.childNode(withName: "respawn5")!,
        ]
        
        var emptyRespawn = respawns[0]
        
        for respawn in respawns {
            var isAvailable = true
            for player in remotePlayers.values {
                if CGRectIntersectsRect(player.component(ofType: SpriteComponent.self)!.frame, respawn.frame) {
                    isAvailable = false
                    break
                }
            }
            
            if isAvailable {
                emptyRespawn = respawn
                break
            }
            
        }
        
        return emptyRespawn.position
        
    }
    
    func killPlayer() {
        joystick.node.removeFromParent()
        jumpButton.node.removeFromParent()
        
        for player in remotePlayers.values {
            if player.type == .man {
                sceneCamera.followCatcher(player)
                break
            }
        }
    }
    
}
