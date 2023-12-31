//
//  Robot.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 28/09/23.
//

import SpriteKit
import GameplayKit

enum Direction {
    case right
    case left
}

enum typeOfPlayer: Codable {
    case dog
    case man
}

class LocalPlayer: GKEntity {
    var playerNumber: Int
    let displayName: String
    var type: typeOfPlayer
    var ready: Bool = false
    var photo: UIImage?
    var adopted: Bool = false
    
    

    init(displayName: String, playerNumber: Int, playerType: typeOfPlayer, photo: UIImage?) {
        self.displayName = displayName
        self.playerNumber = playerNumber
        self.type = playerType
        self.photo = photo
        
        super.init()
        
        let spriteComponent = setPlayerBodySpriteComponent()
        
        let components = [
            SpawnComponent(spawnPrefix: "spawn", spawnNumber: playerNumber),
            spriteComponent,
            DirectionComponent(),
            JumpComponent(Constants.playerJumpXMultiplier, Constants.playerJumpYMultiplier),
            VelocityComponent(type == .dog ? Constants.playerVelocity : Constants.catcherVelocity),
            ScoreComponent(),
            SendPlayerUpdatesComponent(),
            PhysicsComponent(shouldContactWith: .player)
        ]
        
        components.forEach { component in
            addComponent(component)
        }
        
        if type == .man {
            addComponent(CatchComponent())
        } else {
            addComponent(GetCaughtComponent())
            addComponent(HealthComponent())
        }
        
        addComponent(PlayerStateComponent(type == .dog ? PlayerStateMachine(self) : CatcherStateMachine(self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setPlayerBodySpriteComponent() -> SpriteComponent {
        let imageName = (type == .dog ? Constants.playerFramesPrefix  : Constants.catcherFramesPrefix) + "Idle1"
        let size = type == .dog ? CGSize(width: Constants.playerWidth, height: Constants.playerHeight) : CGSize(width: Constants.catcherWidth, height: Constants.catcherHeight)
        
        let spriteComponent = SpriteComponent(imageName: imageName, size: size)
        let body = SKPhysicsBody(rectangleOf: size)
        body.affectedByGravity = true
        body.allowsRotation = false
        body.mass = Constants.playerMass
        
        
        spriteComponent.physicsBody = body
        spriteComponent.zPosition = Zposition.player.rawValue
        
        return spriteComponent
    }
    
}

extension LocalPlayer: Player {}
