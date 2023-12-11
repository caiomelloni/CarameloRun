//
//  ContactComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 01/12/23.
//

import GameplayKit

final class PhysicsComponent: GKComponent {
    
    private let category: PhysicsCategory
    
    init(shouldContactWith category: PhysicsCategory) {
        self.category = category
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        guard let spriteComp = entity?.component(ofType: SpriteComponent.self) else {
            print("ERROR ON Physics Component: did not find sprite component or it was added before")
            return
        }
        
        spriteComp.contactTestBitMask = category.rawValue
    }
    
    override func willRemoveFromEntity() {
        entity?.component(ofType: SpriteComponent.self)?.contactTestBitMask = 0
    }
}
