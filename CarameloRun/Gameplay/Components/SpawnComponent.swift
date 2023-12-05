//
//  SpawnComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 29/11/23.
//

import GameplayKit

class SpawnComponent: GKComponent {
    let spawnPrefix: String
    let spawnNumber: Int
    var respawns: [CGPoint]?

    init(spawnPrefix: String, spawnNumber: Int) {
        self.spawnNumber = spawnNumber
        self.spawnPrefix = spawnPrefix
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getSpawnPosition(_ scene: SKScene) -> CGPoint? {
        let spawnNode = scene.childNode(withName: "\(spawnPrefix)\(spawnNumber)")
        return spawnNode?.position
    }
    
    func getRespawnPoint() -> CGPoint {
        
        guard let respawns = respawns else {
            fatalError("ERROR: could not find respawns because there is none")
        }

        return respawns[Int.random(in: 0..<Constants.respawnCount)]
    }
    
    func addToSceneInSpawnPoint(_ scene: SKScene) {
        
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
