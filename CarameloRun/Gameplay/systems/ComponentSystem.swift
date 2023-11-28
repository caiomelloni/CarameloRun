//
//  ComponentSystem.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 24/11/23.
//

import GameplayKit

class ComponentSystem {
    
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
    }
    
    func removeEntityComponents(foundIn: GKEntity) {
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
