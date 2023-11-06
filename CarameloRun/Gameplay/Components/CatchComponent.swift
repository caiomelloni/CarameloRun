//
//  CatchComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 06/11/23.
//

import Foundation
import GameplayKit

class CatchComponent: GKComponent {
    func didCollide(_ contact: SKPhysicsContact) {
        let entities = _getEntitiesFromContact(contact)
        
        if entities != nil {
            print("colidiu")
        }
        
    }
    
    func _getEntitiesFromContact(_ contact: SKPhysicsContact) -> (localPlayer: GKEntity, remotePlayer: GKEntity)? {
        let entityA = contact.bodyA.node?.entity
        let entityB = contact.bodyB.node?.entity
        
        if entityA == nil || entityB == nil {
            return nil
        }
        
        if entityA == entity {
            return (entityA!, entityB!)
        } else if entityB == entity {
            return (entityB!, entityA!)
        }
        
        return nil
    }
}
