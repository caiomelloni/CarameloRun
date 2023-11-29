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
    let componentSystem = ComponentSystem()
    
    
    
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
        
        componentSystem.addEntityComponents(entity)
        
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
}
