//
//  GetCaughtComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 07/11/23.
//

import GameplayKit

class GetCaughtComponent: GKComponent {
    var isArrested: Bool = false
    
    func gotCaught() {
        guard let respawn = entity?.component(ofType: SpawnComponent.self)?.getRespawnPoint() else {
            fatalError("ERROR: when got caught, the GetCaughtComponent did not find an respawn point")
        }
        
        if !isArrested {
            isArrested = true
            
//            entity?.component(ofType: SpriteComponent.self)?.position.x = respawn.x
//            entity?.component(ofType: SpriteComponent.self)?.position.y = respawn.y
            
            entity?.component(ofType: ScoreComponent.self)?.dogWasCatched()
            
            // must be called after lose velocity end jump components
            let healthPoints = entity?.component(ofType: HealthComponent.self)?.decreaseLife()
            let stateComponent = entity?.component(ofType: PlayerStateComponent.self)
            if healthPoints == 0 {
                stateComponent?.enterDeadState()
            } else {
                stateComponent?.enterArrestState()
            }
        }
    }
    
    func gotFreed() {
        isArrested = false
        
        entity?.component(ofType: PlayerStateComponent.self)?.enterIdleState()
        
    }
}

extension GetCaughtComponent: GetNotifiedWhenContactHappens {
    func didBegin(_ contact: SKPhysicsContact) {
        let contactedEntities = [contact.bodyA.node?.entity, contact.bodyB.node?.entity]
        
        let wasMyEntityContacted = contactedEntities.contains(where: {$0 == entity})
        
        if !wasMyEntityContacted {
            return
        }
        
        for contactEntity in contactedEntities {
            let thisIsNotMyEntity = contactEntity != entity
            let entityType = (contactEntity as? RemotePlayer)?.type
            let entityIsARemoteCatcher = entityType == .man
            
            let entityIsAFreeRemoteDog = entityType == .dog && ((contactEntity as? RemotePlayer)?.component(ofType: PlayerStateComponent.self)?.currentStateType != .arrestState)
            
            if  thisIsNotMyEntity && entityIsARemoteCatcher {
                gotCaught()
            } else if thisIsNotMyEntity && entityIsAFreeRemoteDog && isArrested {
                gotFreed()
            }
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
    }
    
    
}
