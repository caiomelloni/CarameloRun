//
//  PlayerData.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 20/10/23.
//

struct PlayerState: Codable {
    let name: String
    let playerNumber: Int
    let positionX: Double
    let positionY: Double
    //var timer: Int = 15
}

struct PreparingPlayres: Codable {
    var name: String
    var ready: Bool
    var catcher: Int
}
