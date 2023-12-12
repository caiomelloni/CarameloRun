//
//  DirectionComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 27/10/23.
//

import SpriteKit
import GameplayKit

// a component that translates the node
// baseado na variacao de posicao do no
class DirectionComponent:GKComponent {
    var direction: Direction = .right
    
    override init() {
        super.init()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeDirection(_ direction: Direction) {
        if let nodeComponent = entity?.component(ofType: SpriteComponent.self) {
            switch direction {
            case .right:
                self.direction = .right
                nodeComponent.xScale = 1
            case .left:
                self.direction = .left
                nodeComponent.xScale = -1
            }
        }
    }
    
    func positionChanged(_ oldX: Double, _ newX: Double) {
        let dx = (oldX) - newX
        if entity?.component(ofType: PlayerStateComponent.self)?.currentStateType == .arrestState {
            changeDirection(.right)
        } else if dx > 0 {
            changeDirection(.left)
        } else if dx < 0{
            changeDirection(.right)
        }
    }
    

}
