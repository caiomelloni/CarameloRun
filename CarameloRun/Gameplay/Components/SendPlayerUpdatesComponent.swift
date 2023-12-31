//
//  OnlineMatchComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 01/12/23.
//

import GameplayKit
import GameKit

class SendPlayerUpdatesComponent: GKComponent {
    var match: GKMatch?
    
    func updatePlayerPositionForOtherPlayers() {
        let localPlayer = entity as! LocalPlayer
        if entity?.component(ofType: SpriteComponent.self)?.hasChanged() ?? false {
            let playerState = PlayerData(name: GKLocalPlayer.local.displayName,
                                          playerNumber: localPlayer.playerNumber,
                                          positionX: localPlayer.component(ofType: SpriteComponent.self)!.position.x,
                                          positionY: localPlayer.component(ofType: SpriteComponent.self)!.position.y,
                                          state: (localPlayer.component(ofType: PlayerStateComponent.self)?.currentStateType.rawValue ?? StateType.deadState.rawValue))
            
            do {
                let data = try JSONEncoder().encode(playerState)
                
                try match!.sendData(toAllPlayers: data, with: GKMatch.SendDataMode.unreliable)
            } catch {
                print("ERROR sending data")
            }
        }
    }
    
    func finishMatch() {
        do {
            let data = try JSONEncoder().encode(MatchState(finish: true))
            try match!.sendData(toAllPlayers: data, with: GKMatch.SendDataMode.unreliable)
        } catch {
            print("ERROR sending data")
        }
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        updatePlayerPositionForOtherPlayers()
    }
}
