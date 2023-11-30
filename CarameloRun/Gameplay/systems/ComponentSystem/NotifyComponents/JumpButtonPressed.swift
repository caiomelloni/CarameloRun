//
//  ComponentSystemExtension.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 29/11/23.
//

import GameplayKit

extension ComponentSystem {
    func notifyJumpButtonPressed() {
        for comp in components(ofType: GetNotifiedWhenJumpButtonIsPressed.self) {
            comp.jumpButtonPressed()
        }
    }
    
}

protocol GetNotifiedWhenJumpButtonIsPressed {
    func jumpButtonPressed()
}
