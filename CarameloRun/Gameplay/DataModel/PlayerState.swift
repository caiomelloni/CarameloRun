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

struct matchState: Codable {
    var finish: Bool
}

struct taskDone: Codable {
    var frameOfTheTask: CGRect
    var done: Bool
}

enum PlayerStateStringIdentifier: String {
    case idleState = "idle"
    case runState = "isRunnig"
    case fallState = "fall"
    case jumpState = "jump"
    case arrestState = "arrest"
    case deadState = "dead"
    case winnerState = "winner"
}


