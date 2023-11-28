//
//  LocalPlayerCamera.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 30/10/23.
//

import SpriteKit

// cria uma camera que segue o jogador especificado
class LocalPlayerCamera: SKCameraNode {
    var player: Player
    let scaleFactorY: CGFloat = 1.75
    let scaleFactorX: CGFloat = 1.75
    init(_ playerToFollow: Player) {
        self.player = playerToFollow
        super.init()
        
        //set the camera size
        xScale = scaleFactorX
        yScale = scaleFactorY
    }
    
    private func updateCameraPosition() {
        position.x = player.component(ofType: SpriteComponent.self)!.position.x
        position.y = player.component(ofType: SpriteComponent.self)!.position.y
    }
    
    func followCatcher(_ catcher: Player) {
        player = catcher
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ currentTime: TimeInterval) {
        updateCameraPosition()
    }
}
