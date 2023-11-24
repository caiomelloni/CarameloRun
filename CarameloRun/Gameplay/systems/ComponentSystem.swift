//
//  ComponentSystem.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 24/11/23.
//

import GameplayKit

class ComponentSystem {
    var toRemove = Set<GKEntity>()
    
    // add the components that needs to be update by each frame
    lazy var componentSystems: [GKComponentSystem] = {
        return [
            GKComponentSystem(componentClass: PlayerAnimationComponent.self),
            GKComponentSystem(componentClass: JumpComponent.self),
            GKComponentSystem(componentClass: CatchComponent.self),
        ]
    }()
    
    func update(_ deltaTime: CFTimeInterval) {
        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: deltaTime)
        }
        
        //if the entity was removed, then its components must not listen to frame updates
        for entity in toRemove {
            removeComponents(foundIn: entity)
        }
        toRemove.removeAll()
    }
    
    func removeEntityComponents(_ entity: GKEntity) {
        toRemove.insert(entity)
    }
    
    private func removeComponents(foundIn: GKEntity) {
        for componentSystem in componentSystems {
            componentSystem.removeComponent(foundIn: foundIn)
        }
    }
    
    // conects the components of the entity with the component system
    // so it can listen to frame updates
    func addEntityComponents(_ entity: GKEntity) {
        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
    }
}
