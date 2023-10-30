//
//  SpriteAnimationComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 27/10/23.
//

import SpriteKit
import GameplayKit

// The entity must have a SpriteComponent to work
// To do: implement the walk movement call here when updating for the next frame, by adding the velocity component
class SpriteWalkAnimationComponent: GKComponent {
    let firstSprite: Int
    let lastSprite: Int
    private var currentSprite: Int
    let spriteName: String
    
    init(_ firstSprite: Int, _ lastSprite: Int, _ spriteName: String) {
        self.firstSprite = firstSprite
        self.lastSprite = lastSprite
        self.currentSprite = firstSprite
        self.spriteName = spriteName
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func nextSprite() {
        if let spriteComponent = entity?.component(ofType: SpriteComponent.self) {
            spriteComponent.texture = SKTexture(imageNamed: spriteName + String(currentSprite))
            if currentSprite == lastSprite {
                currentSprite = firstSprite
            } else {
                currentSprite += 1
            }
        }
        
    }
}
