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
    let finishGame: (()->Void)
    
    
    
    init(scene: GameScene, finishGame: @escaping (()->Void)) {
        self.scene = scene
        self.finishGame = finishGame
    }
    
    func addEntity(_ entity: GKEntity) {
        entities.insert(entity)
        
        entity.component(ofType: SendPlayerUpdatesComponent.self)?.match = scene.controllerDelegate?.match
        
        entity.component(ofType: SpawnComponent.self)?.addToSceneInSpawnPoint(scene)
        
        let catchComponent = entity.component(ofType: CatchComponent.self)
        catchComponent?.finishGame = finishGame
        
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
    
    //TODO: use component notification for remote players update
    func updateRemotePlayerPosition(_ playerState: PlayerData) {
        let newPosition = CGPoint(x: playerState.positionX, y: playerState.positionY)
        guard let remotePlayer = getRemotePlayer(ofPlayerNumber: playerState.playerNumber), let localPlayer = localPlayer else {
            print("ERROR on EntityManager updateRemotePlayerPosition :remote player not found on update")
            return
        }
        
        let stateStringIdentifier = StateType(rawValue: playerState.state)
        
        remotePlayer.updateFromDataReceived(newPosition, stateStringIdentifier!)
        
        componentSystem.notifyPlayerUpdate(localPlayer, remotePlayers, remotePlayer)
    }
    
}


//MARK: Events
//component notification
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        componentSystem.notifyContactBegin(contact)
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        componentSystem.notifyContactEnd(contact)
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


//MARK: Helper tools
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
