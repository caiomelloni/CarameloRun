//
//  Player.swift
//  CarameloRun
//
//  Created by Marcelo Pastana Duarte on 11/12/23.
//

import Foundation
import UIKit
import GameplayKit

protocol Player: GKEntity {
    var playerNumber: Int { get }
    var displayName: String { get }
    var type: typeOfPlayer { get }
    var ready: Bool { get }
    var photo: UIImage? { get }
    var adopted: Bool { get }
}
