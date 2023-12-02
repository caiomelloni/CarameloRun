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
            print("ERROR: when got caught, the GetCaughtComponent did not find an respawn point")
            return
        }
        
        if !isArrested {
            isArrested = true
//            entity?.component(ofType: SpriteComponent.self)?.position = respawn
//            entity?.component(ofType: SpriteComponent.self)?.position = CGPoint(x: 0, y: 0)
            print(entity?.component(ofType: SpriteComponent.self)?.position)
            
            entity?.component(ofType: ScoreComponent.self)?.dogWasCatched()
            
            // removes player movement
            entity?.removeComponent(ofType: VelocityComponent.self)
            entity?.removeComponent(ofType: JumpComponent.self)
            
            // must be called after lose velocity end jump components
            let healthPoints = entity?.component(ofType: HealthComponent.self)?.decreaseLife()
            let animationComponent = entity?.component(ofType: PlayerStateComponent.self)
            if healthPoints == 0 {
                animationComponent?.dead()
            } else {
                animationComponent?.arrest()
            }
        }
    }
    
    func gotFreed() {
        isArrested = false
        
        entity?.component(ofType: PlayerStateComponent.self)?.idle()
        
        // adds player movement
        entity?.addComponent(VelocityComponent(Constants.playerVelocity))
        entity?.addComponent(JumpComponent(Constants.playerJumpXMultiplier, Constants.playerJumpYMultiplier))
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
            
            let entityIsAFreeRemoteDog = entityType == .dog && !((contactEntity as? RemotePlayer)?.component(ofType: GetCaughtComponent.self)?.isArrested ?? true)
            
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
