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
        for player in scene.remotePlayers.values {
            if player.type == .dog && frame.contains(player.component(ofType: SpriteComponent.self)!.position) == true && player.adopted == false{
                player.adopted = true
                player.component(ofType: PlayerAnimationComponent.self)?.winner()
                
                if scene.remotePlayers.count == countPlayersThatDontMove(){
                    scene.controllerDelegate?.finishGame()
                }
            }
        }
        
        if scene.localPlayer.type == .dog && frame.contains(scene.localPlayer.component(ofType: SpriteComponent.self)!.position) == true && scene.localPlayer.adopted == false{
            scene.localPlayer.adopted = true
            scene.localPlayer.component(ofType: ScoreComponent.self)?.dogAdopted()
            scene.localPlayer.component(ofType: PlayerAnimationComponent.self)?.winner()
            scene.killPlayer()
            
            if scene.remotePlayers.count == countPlayersThatDontMove(){
                scene.controllerDelegate?.finishGame()
            }
            
        }
        
    }
    
    
    func countPlayersThatDontMove() -> Int{
        var numberOfDogsArrestedOrDeadOrWinner = 0
        for player in scene.remotePlayers.values {
            let state = player.component(ofType: PlayerAnimationComponent.self)?.stateMachine.currentState as? CodableState
            let currentPlayerState = PlayerStateStringIdentifier(rawValue: state?.stringIdentifier ?? PlayerStateStringIdentifier.deadState.rawValue)
            if currentPlayerState == .arrestState || currentPlayerState == .deadState || currentPlayerState == .winnerState {
                numberOfDogsArrestedOrDeadOrWinner += 1
            }
            print("\(player.displayName) - \(player.type): \(currentPlayerState?.rawValue ?? "nulo")")
        }
        
        let state = scene.localPlayer.component(ofType: PlayerAnimationComponent.self)?.stateMachine.currentState as? CodableState
        let currentPlayerState = PlayerStateStringIdentifier(rawValue: state?.stringIdentifier ?? PlayerStateStringIdentifier.deadState.rawValue)
        if currentPlayerState == .arrestState || currentPlayerState == .deadState || currentPlayerState == .winnerState {
            numberOfDogsArrestedOrDeadOrWinner += 1
        }
        print("\(scene.localPlayer.displayName) - \(scene.localPlayer.type): \(currentPlayerState?.rawValue ?? "nulo")")
        
        return numberOfDogsArrestedOrDeadOrWinner
    }
    
    func countPlayersAdopteds() -> Int {
        var numberOfDogsAdopteds = 0
        for player in scene.remotePlayers.values {
            if player.adopted {
                numberOfDogsAdopteds += 1
            }
        }
        
        if scene.localPlayer.adopted {
            numberOfDogsAdopteds += 1
        }
        
        return numberOfDogsAdopteds
        
    }

}
