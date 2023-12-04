//
//  JoystickStateChanged.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 29/11/23.
//

import GameplayKit

extension ComponentSystem {
    func notifyJoystickStateChanged(inUse: Bool, direction: Direction) {
        for comp in components(ofType: GetNotifiedWhenJoystickStateChanges.self) {
            comp.joystickStateChanged(inUse: inUse, direction: direction)
        }
    }
    
}

protocol GetNotifiedWhenJoystickStateChanges {
    func joystickStateChanged(inUse: Bool, direction: Direction)
}
