//
//  ComponentSystem.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 24/11/23.
//

import GameplayKit

//MARK: a know way to improve performance is to make notifications more specifically
//by avoid looping the componentSystems all the time
class ComponentSystem {
    
    // add the components that needs to be update by each frame
    lazy var componentSystems: [GKComponentSystem] = {
        return [
            GKComponentSystem(componentClass: PlayerAnimationComponent.self),
            GKComponentSystem(componentClass: SpriteComponent.self),
            GKComponentSystem(componentClass: PlayerAnimationComponent.self),
            GKComponentSystem(componentClass: JumpComponent.self),
            GKComponentSystem(componentClass: CatchComponent.self),
            GKComponentSystem(componentClass: SpawnComponent.self),
            GKComponentSystem(componentClass: VelocityComponent.self)
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
    
    func components<T>(ofType: T.Type) -> [T] {
        var comps = [T]() 
        for system in componentSystems {
            if system.components.first as? T == nil {
                continue
            }
            
            for comp in system.components {
                comps.append(comp as! T)
            }
            break
        }
        
        return comps
    }
}
