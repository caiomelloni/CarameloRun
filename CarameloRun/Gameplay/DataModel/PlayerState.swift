//
//  PlayerData.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 20/10/23.
//
import GameplayKit

struct PlayerState: Codable {
    let name: String
    let playerNumber: Int
    let positionX: Double
    let positionY: Double
    let state: String
    
}

struct PreparingPlayres: Codable {
    var name: String
    var ready: Bool
    var catcher: Int
}

struct IsCatcher: Codable {
    var catcher: Int
    var name: String
}
