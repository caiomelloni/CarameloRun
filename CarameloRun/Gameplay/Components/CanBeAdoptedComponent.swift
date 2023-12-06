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
        let remotePlayers = scene.entityManager.remotePlayers
        
        for player in remotePlayers {
            if player.type == .dog && frame.contains(player.component(ofType: SpriteComponent.self)!.position) == true && player.adopted == false{
                player.adopted = true
                player.component(ofType: PlayerAnimationComponent.self)?.winner()
                
                if remotePlayers.count == countPlayersThatDontMove(){
                    scene.controllerDelegate?.finishGame()
                }
            }
        }
        
        if localPlayer.type == .dog && frame.contains(localPlayer.component(ofType: SpriteComponent.self)!.position) == true && localPlayer.adopted == false{
            localPlayer.adopted = true
            localPlayer.component(ofType: ScoreComponent.self)?.dogAdopted()
            localPlayer.component(ofType: PlayerAnimationComponent.self)?.winner()
            localPlayer.component(ofType: SpriteComponent.self)?.removeFromParent()
            scene.killPlayer()
            
            if remotePlayers.count == countPlayersThatDontMove(){
                scene.controllerDelegate?.finishGame()
            }
            
        }
        
    }
    
    
    func countPlayersThatDontMove() -> Int{
        let localPlayer = scene.entityManager.localPlayer!
        let remotePlayers = scene.entityManager.remotePlayers
        
        var numberOfDogsArrestedOrDeadOrWinner = 0
        for player in remotePlayers {
            let state = player.component(ofType: PlayerAnimationComponent.self)?.stateMachine.currentState as? CodableState
            let currentPlayerState = PlayerStateStringIdentifier(rawValue: state?.stringIdentifier ?? PlayerStateStringIdentifier.deadState.rawValue)
            if currentPlayerState == .arrestState || currentPlayerState == .deadState || currentPlayerState == .winnerState {
                numberOfDogsArrestedOrDeadOrWinner += 1
            }
            print("\(player.displayName) - \(player.type): \(currentPlayerState?.rawValue ?? "nulo")")
        }
        
        let state = localPlayer.component(ofType: PlayerAnimationComponent.self)?.stateMachine.currentState as? CodableState
        let currentPlayerState = PlayerStateStringIdentifier(rawValue: state?.stringIdentifier ?? PlayerStateStringIdentifier.deadState.rawValue)
        if currentPlayerState == .arrestState || currentPlayerState == .deadState || currentPlayerState == .winnerState {
            numberOfDogsArrestedOrDeadOrWinner += 1
        }
        print("\(localPlayer.displayName) - \(localPlayer.type): \(currentPlayerState?.rawValue ?? "nulo")")
        
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
