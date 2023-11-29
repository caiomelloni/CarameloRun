//
//  SpawnComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 29/11/23.
//

import GameplayKit

class SpawnComponent: GKComponent {
    let spawnNumber: Int
    init(spawnNumber: Int) {
        self.spawnNumber = spawnNumber
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getSpawnPosition(_ scene: SKScene) -> CGPoint? {
        let spawnNode = scene.childNode(withName: "spawn\(spawnNumber)")
        return spawnNode?.position
    }
    
}


extension SpawnComponent: GetNotifiedWhenAddedToScene {
    func didAddToScene(_ scene: SKScene) {
        
        //TODO: treat errors in a better way
        guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else {
            print("ERROR: SpawnComponent did not find SpriteComponent")
            return
        }
        guard let spawnPosition = getSpawnPosition(scene) else {
            print("ERROR: SpawnComponent did not find spawn point")
            return
        }
        spriteComponent.addToScene(scene)
        spriteComponent.position = spawnPosition
    }
}
