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
        
        guard let players = players else {
            //TODO: treat errors in a better way
            print("ERROR: NULL PLAYERS")
            return
        }
        
        entityManager.initPlayersEntities(lobbyPlayers: players)
        
    }
    
    func updatePlayersPosition(_ playerState: PlayerState) {
        print("received player data")
        let newPosition = CGPoint(x: playerState.positionX, y: playerState.positionY)
        let player = entityManager.getRemotePlayer(ofPlayerNumber: playerState.playerNumber)
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
        let localPlayer = entityManager.localPlayer!
        let remotePlayers = entityManager.remotePlayers
        for remotePlayer in remotePlayers {
            if CGRectIntersectsRect(localPlayer.component(ofType: SpriteComponent.self)!.frame, remotePlayer.component(ofType: SpriteComponent.self)!.frame) {
                if remotePlayer.type == .man {
                    localPlayer.component(ofType: GetCaughtComponent.self)?.gotCaught(emptyRespawnPoint(localPlayer))
                } else if (remotePlayer.component(ofType: PlayerAnimationComponent.self)?.stateMachine.currentState as? ArrestedState) == nil {
                    localPlayer.component(ofType: GetCaughtComponent.self)?.gotFreed()
                }
                
                // just called by a catcher
                localPlayer.component(ofType: CatchComponent.self)?
                    .didCollideWithPlayer(remotePlayer, remotePlayers,
                                          finishGame: {
                        self.controllerDelegate?.sendMatchState(matchState.init(finish: true))
                        self.controllerDelegate?.finishGame()
                    }
                    )
                
                
                
            }
        }
    }
    
    private func emptyRespawnPoint(_ player: GKEntity) -> CGPoint {
        var respawns = [SKNode]()
        
        for i in 1...Constants.respawnCount {
            respawns.append(scene!.childNode(withName: "respawn\(i)")!)
        }
        
        var emptyRespawn = respawns[0]
        
        for respawn in respawns {
            var isAvailable = true
            for player in entityManager.remotePlayers {
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
    
    func removeJoystickAndJumpButton() {
        joystick.removeFromScene()
        jumpButton.node.removeFromParent()
    }
    
}
