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
}

struct PreparingPlayres: Codable {
    var name: String
    var ready: Bool
    var type0: typeOfPlayer
    var type1: typeOfPlayer
    var type2: typeOfPlayer
}
