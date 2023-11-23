//
//  Constants.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 25/10/23.
//

class Constants {
    static let playerJumpXMultiplier: Double = 2.5
    static let playerJumpYMultiplier: Double = 5.5
    static let charactersCollisionMask: UInt32 = 1
    
    
    static let playerVelocity: Double = 15
    
    static let playerHeight: Double = 150
    static let playerWidth: Double = 150
    static let catcherHeight: Double = 216
    static let catcherWidth: Double = 150
    
    //player frames count
    static let playerFallFramesCount: Int = 7
    static let playerJumpFramesCount: Int = 14
    static let playerIdleFramesCount: Int = 7
    static let playerRunFramesCount: Int = 8
    static let playerArrestedFramesCount: Int = 22
    static let playerFramesPrefix: String = "dog"
    
    //catcher frames count
    static let catcherFallFramesCount: Int = 2
    static let catcherJumpFramesCount: Int = 13
    static let catcherIdleFramesCount: Int = 2
    static let catcherRunFramesCount: Int = 8
    static let catcherFramesPrefix: String = "catcher"

    //respawn
    static let respawnCount: Int = 2
}
