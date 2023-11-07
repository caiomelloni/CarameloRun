//
//  CatchComponent.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 06/11/23.
//

import Foundation
import GameplayKit

class CatchComponent: GKComponent {
    func didCollideWithPlayer(_ player: Player) {
        entity?.component(ofType: ScoreComponent.self)?.humanCatch()
    }
}
