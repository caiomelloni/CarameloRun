//
//  LobbyPlayer.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 22/11/23.
//

import GameKit

struct LobbyPlayer {
    var playerNumber: Int
    let displayName: String
    var playerType: typeOfPlayer
    var ready: Bool = false
    let photo: UIImage?
}
