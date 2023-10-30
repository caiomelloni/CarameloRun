//
//  EntityManager.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 26/10/23.
//

import Foundation
import SpriteKit
import GameplayKit

class EntityManager {
    
    var entities = Set<GKEntity>()
    let scene: SKScene
    var toRemove = Set<GKEntity>()
    
    // add the components that needs to be update by each frame
    lazy var componentSystems: [GKComponentSystem] = {
        
        return [
            // component system insertion example:
            // GKComponentSystem(componentClass: DirectionComponent.self)
            GKComponentSystem(componentClass: PlayerAnimationComponent.self)
        ]
    }()
    
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func addEntity(_ entity: GKEntity, spawnPoint: CGPoint? = nil) {
        entities.insert(entity)
        
        if let spriteComponent = entity.component(ofType: SpriteComponent.self) {
            spriteComponent.addToScene(scene)
            if let spawnPoint {
                spriteComponent.position = spawnPoint
            }
        }
    
        addEntityComponentsToComponentsSystems(entity)
        
    }
    
    func remove(_ entity: GKEntity) {
        if let spriteComponent = entity.component(ofType: SpriteComponent.self) {
            spriteComponent.removeFromParent()
        }
        
        entities.remove(entity)
        toRemove.insert(entity)
    }
    
    func update(_ deltaTime: CFTimeInterval) {
        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: deltaTime)
        }
        
        //if the entity was removed, then its components must not listen to frame updates
        for curRemove in toRemove {
            for componentSystem in componentSystems {
                componentSystem.removeComponent(foundIn: curRemove)
            }
        }
        toRemove.removeAll()
    }
    
    // conects the components of the entity with the component system
    // so it can listen to frame updates
    private func addEntityComponentsToComponentsSystems(_ entity: GKEntity) {
        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
    }
    
}
