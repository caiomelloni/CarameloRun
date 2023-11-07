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
    init(_ playerToFollow: Player) {
        self.player = playerToFollow
        super.init()
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
