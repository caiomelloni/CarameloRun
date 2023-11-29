//
//  LocalPlayerCamera.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 30/10/23.
//

import SpriteKit

// cria uma camera que segue o jogador especificado
class LocalPlayerCamera: SKCameraNode {
    var playerSpriteComponent: SpriteComponent
    let scaleFactorY: CGFloat = 1.75
    let scaleFactorX: CGFloat = 1.75
    init(_ playerToFollow: LocalPlayer) {
        guard let spriteComp = playerToFollow.component(ofType: SpriteComponent.self) else {
            //TODO: treat error in a better way
            print("****Error on local player camera!*******")
            self.playerSpriteComponent = SpriteComponent(imageName: "Dumb", size: CGSize(width: 7, height: 7))
            super.init()
            return
        }
        self.playerSpriteComponent = spriteComp
        
        
        super.init()
        
        //set the camera size
        xScale = scaleFactorX
        yScale = scaleFactorY
    }
    
    private func updateCameraPosition() {
        position.x = playerSpriteComponent.position.x
        position.y = playerSpriteComponent.position.y
    }
    
    func followCatcher(_ catcher: RemotePlayer) {
        guard let spriteComp = catcher.component(ofType: SpriteComponent.self) else {
            print("Error on local player camera!")
            return
        }
        playerSpriteComponent = spriteComp
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ currentTime: TimeInterval) {
        updateCameraPosition()
    }
}
