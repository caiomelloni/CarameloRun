//
//  LocalPlayerCamera.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 30/10/23.
//

import SpriteKit

class LocalPlayerCamera: SKCameraNode {
    let player: Player
    init(_ player: Player) {
        self.player = player
        super.init()
    }
    
    private func updateCameraPosition() {
        position.x = player.component(ofType: SpriteComponent.self)!.position.x
        position.y = player.component(ofType: SpriteComponent.self)!.position.y
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ currentTime: TimeInterval) {
        updateCameraPosition()
    }
}
