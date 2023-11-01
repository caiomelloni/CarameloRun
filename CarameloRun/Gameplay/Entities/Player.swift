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

class Player: GKEntity {
    var playerNumber: Int
    let displayName: String
    var type: typeOfPlayer
    var ready: Bool = false
    
    
    
    init(displayName: String, playerNumber: Int, playerType: typeOfPlayer) {
        self.displayName = displayName
        self.playerNumber = playerNumber
        self.type = playerType
        
        
        super.init()
        
        let spriteComponent = setPlayerBodySpriteComponent(SpriteComponent(texture: SKTexture(imageNamed: "Idle1"), size: CGSize(width: Constants.playerWidth, height: Constants.playerHeight)))
        
        [
            spriteComponent,
            DirectionComponent(),
            JumpComponent(Constants.playerJumpXMultiplier, Constants.playerJumpYMultiplier),
            VelocityComponent(Constants.playerVelocity),
            
            PlayerAnimationComponent(type == .dog ? PlayerStateMachine(spriteComponent) : CatcherStateMachine(spriteComponent))
            
        ].forEach { component in
            addComponent(component)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setPlayerBodySpriteComponent(_ spriteComponent: SpriteComponent) -> SpriteComponent {
        let body = SKPhysicsBody(texture: SKTexture(imageNamed: "Idle1"),
                                 size: CGSize(width: Constants.playerWidth, height: Constants.playerHeight))
        body.affectedByGravity = true
        body.allowsRotation = false
        
        spriteComponent.physicsBody = body
        
        spriteComponent.zPosition = Zposition.player.rawValue
        
        return spriteComponent
    }
    
}
