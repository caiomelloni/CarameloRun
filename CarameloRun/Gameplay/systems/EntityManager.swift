//
//  EntityManager.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 26/10/23.
//

import Foundation
import SpriteKit
import GameplayKit
import GameKit

//MARK: a known way to improve performance is to make the access to certain entity faster
class EntityManager {
    
    var entities = Set<GKEntity>()
    let scene: GameScene
    let componentSystem = ComponentSystem()
    
    
    
    init(scene: GameScene) {
        self.scene = scene
    }
    
    func addEntity(_ entity: GKEntity) {
        entities.insert(entity)
        
        
        componentSystem.addEntityComponents(entity)
        componentSystem.notifyAddedToScene(scene: scene)
    }
    
    func remove(_ entity: GKEntity) {
        if let spriteComponent = entity.component(ofType: SpriteComponent.self) {
            spriteComponent.removeFromParent()
        }
        
        entities.remove(entity)
        componentSystem.removeEntityComponents(foundIn: entity)
    }
    
    func initPlayersEntities(lobbyPlayers: [LobbyPlayer]) {
        for playerFromPreparing in lobbyPlayers {
            
            var player :GKEntity
            
            if playerFromPreparing.displayName == GKLocalPlayer.local.displayName {
                let localPlayer = LocalPlayer(displayName: playerFromPreparing.displayName, playerNumber: playerFromPreparing.playerNumber, playerType: playerFromPreparing.playerType, photo: playerFromPreparing.photo)
                player = localPlayer
            } else {
                player = RemotePlayer(displayName: playerFromPreparing.displayName, playerNumber: playerFromPreparing.playerNumber, playerType: playerFromPreparing.playerType, photo: playerFromPreparing.photo)
            }
            
            player.component(ofType: HealthComponent.self)?.killPlayerRef = killPlayer
            addEntity(player)
        }
        
    }
    
    func killPlayer() {
        scene.removeJoystickAndJumpButton()
        
        for player in remotePlayers {
            if player.type == .man {
                scene.sceneCamera.followCatcher(player)
                break
            }
        }
    }
    
}


//Events
extension EntityManager {
    func update(_ deltaTime: CFTimeInterval) {
        componentSystem.update(deltaTime)
    }
    
    func joystickStateChanged(inUse: Bool, direction: Direction) {
        componentSystem.notifyJoystickStateChanged(inUse: inUse, direction: direction)
    }
    
    func jumpButtonPressed() {
        componentSystem.notifyJumpButtonPressed()
    }
}

//TODO: Remove it, and place the entity logic inside the entity manager
//Getter methods
extension EntityManager {
    var localPlayer: LocalPlayer? {
        return getEntities(ofType: LocalPlayer.self).first
    }
    
    func getRemotePlayer(ofPlayerNumber playerNumber: Int) -> RemotePlayer? {
        let remotePlayers = getEntities(ofType: RemotePlayer.self)
        return remotePlayers.first(where: {$0.playerNumber == playerNumber})
    }
    
    var remotePlayers: [RemotePlayer] {
        getEntities(ofType: RemotePlayer.self)
    }
}


//Private helper tools
extension EntityManager {
    private func getEntities<T: AnyObject>(ofType type: T.Type) -> [T] {
        var array: [T] = []
        for elem in entities {
            if let elem = elem as? T {
                array.append(elem)
            }
        }
        return array
    }
}
