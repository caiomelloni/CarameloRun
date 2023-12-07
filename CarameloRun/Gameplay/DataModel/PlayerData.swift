//
//  PlayerData.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 20/10/23.
//
import GameplayKit

struct PlayerData: Codable {
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
struct taskDone: Codable {
    var frameOfTheTask: CGRect
    var done: Bool
}
