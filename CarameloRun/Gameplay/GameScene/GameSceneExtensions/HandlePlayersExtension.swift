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
    
//    func handlePlayerCollision() {
//        let localPlayer = entityManager.localPlayer!
//        let remotePlayers = entityManager.remotePlayers
//        for remotePlayer in remotePlayers {
//            if CGRectIntersectsRect(localPlayer.component(ofType: SpriteComponent.self)!.frame, remotePlayer.component(ofType: SpriteComponent.self)!.frame) {
//                if remotePlayer.type == .man {
//                    localPlayer.component(ofType: GetCaughtComponent.self)?.gotCaught()
//                } else if (remotePlayer.component(ofType: PlayerStateComponent.self)?.stateMachine.currentState as? ArrestedState) == nil {
//                    localPlayer.component(ofType: GetCaughtComponent.self)?.gotFreed()
//                }
//                
//                // just called by a catcher
//                localPlayer.component(ofType: CatchComponent.self)?
//                    .didCollideWithPlayer(remotePlayer, remotePlayers,
//                                          finishGame: {
//                        self.controllerDelegate?.sendMatchState(matchState.init(finish: true))
//                        self.controllerDelegate?.finishGame()
//                    }
//                    )
//                
//                
//                
//            }
//        }
//    }
    
    func getRespawns() -> [CGPoint] {
        var respawns = [CGPoint]()
        
        for i in 1...Constants.respawnCount {
            let respawnNode = scene!.childNode(withName: "respawn\(i)")!
            respawns.append(convert(respawnNode.position, to: respawnNode))
        }
        
        return respawns
    }
    
    func removeJoystickAndJumpButton() {
        joystick.removeFromScene()
        jumpButton.removeFromScene()
    }
    
}
