//
//  Robot.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 28/09/23.
//

import SpriteKit
import GameplayKit

class RemotePlayer: GKEntity {
    var playerNumber: Int
    let displayName: String
    var type: typeOfPlayer
    var ready: Bool = false
    var photo: UIImage?
    
    
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
            ScoreComponent(),
            PlayerStateComponent(type == .dog ? PlayerStateMachine(spriteComponent) : CatcherStateMachine(spriteComponent)),
            PhysicsComponent(shouldContactWith: .player)
        ]
        
        components.forEach { component in
            addComponent(component)
        }
        
//        if type == .man {
//            addComponent(CatchComponent())
//        } else {
//            addComponent(GetCaughtComponent())
//            addComponent(HealthComponent())
//        }
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
    
    func updateFromDataReceived(_ newPosition: CGPoint, _ stateStringIdentifier: PlayerStateStringIdentifier?){
        let spriteComp = component(ofType: SpriteComponent.self)
        spriteComp?.position = newPosition
        
        let animationComp = component(ofType: PlayerStateComponent.self)
        
        switch stateStringIdentifier {
        case .idleState:
            animationComp?.idle()
        case .runState:
            animationComp?.run()
        case .fallState:
            animationComp?.fall()
        case .jumpState:
            animationComp?.jump()
        case .arrestState:
            animationComp?.arrest()
        case .deadState:
            animationComp?.dead()
        default:
            print("=> func updatePlayerPosition: no state detected for the remote player")
        }
    }
    
}

