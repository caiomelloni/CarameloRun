//
//  ComponentSystemExtension.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 29/11/23.
//

import GameplayKit

extension ComponentSystem {
    func notifyContactBegin(_ contact: SKPhysicsContact) {
        for comp in components(ofType: GetNotifiedWhenContactHappens.self) {
            comp.didBegin(contact)
        }
    }
    
    func notifyContactEnd(_ contact: SKPhysicsContact) {
        for comp in components(ofType: GetNotifiedWhenContactHappens.self) {
            comp.didEnd(contact)
        }
    }
    
}

protocol GetNotifiedWhenContactHappens {
    func didBegin(_ contact: SKPhysicsContact)
    func didEnd(_ contact: SKPhysicsContact)
}
