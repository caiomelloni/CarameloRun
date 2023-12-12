//
//  CanBeAdoptedComponent.swift
//  CarameloRun
//
//  Created by Luis Silva on 29/11/23.
//

import GameplayKit
import SpriteKit

class CanBeAdoptedComponent: GKComponent {
    
    var scene: GameScene
    var frame: CGRect
    var numberOfDogsAdopteds: Int = 0
    
    init(_ scene: GameScene, _ frame: CGRect ) {
        self.scene = scene
        self.frame = frame
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func verifyIfTheDosHasBeenAdopted() {
        let localPlayer = scene.entityManager.localPlayer!
        
        if localPlayer.type == .dog && frame.contains(localPlayer.component(ofType: SpriteComponent.self)!.position) == true && localPlayer.adopted == false{
            localPlayer.component(ofType: PlayerStateComponent.self)?.enterWinnerState()
            localPlayer.component(ofType: SendPlayerUpdatesComponent.self)?.updatePlayerPositionForOtherPlayers()
            localPlayer.adopted = true
            localPlayer.component(ofType: ScoreComponent.self)?.dogAdopted()
            scene.entityManager.killPlayer()
            
        }
        
    }
    
    
    func countPlayersThatDontMove() -> Int{
        let localPlayer = scene.entityManager.localPlayer!
        let remotePlayers = scene.entityManager.remotePlayers
        
        var numberOfDogsArrestedOrDeadOrWinner = 0
        for player in remotePlayers {
            let state = player.component(ofType: PlayerStateComponent.self)?.currentStateType

            if state == .arrestState || state == .deadState || state == .winnerState {
                numberOfDogsArrestedOrDeadOrWinner += 1
            }
        }
        
        let state = localPlayer.component(ofType: PlayerStateComponent.self)?.currentStateType

        if state == .arrestState || state == .deadState || state == .winnerState {
            numberOfDogsArrestedOrDeadOrWinner += 1
        }

        
        return numberOfDogsArrestedOrDeadOrWinner
    }
    
    func countPlayersAdopteds() -> Int {
        let localPlayer = scene.entityManager.localPlayer!
        let remotePlayers = scene.entityManager.remotePlayers
        
        var numberOfDogsAdopteds = 0
        for player in remotePlayers {
            if player.adopted {
                numberOfDogsAdopteds += 1
            }
        }
        
        if localPlayer.adopted {
            numberOfDogsAdopteds += 1
        }
        
        return numberOfDogsAdopteds
        
    }

}
