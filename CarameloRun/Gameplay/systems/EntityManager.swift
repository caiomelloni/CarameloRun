//
//  EntityManager.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 26/10/23.
//

import Foundation
import SpriteKit
import GameplayKit

//MARK: a known way to improve performance is to make the access to certain entity faster
class EntityManager {
    
    var entities = Set<GKEntity>()
    let scene: SKScene
    let componentSystem = ComponentSystem()
    
    
    
    init(scene: SKScene) {
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
    
    func update(_ deltaTime: CFTimeInterval) {
        componentSystem.update(deltaTime)
    }
    
    func joystickStateChanged(inUse: Bool, direction: Direction) {
        componentSystem.notifyJoystickStateChanged(inUse: inUse, direction: direction)
    }

    
}

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
