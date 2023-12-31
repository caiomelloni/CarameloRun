//
//  Constants.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 25/10/23.
//

struct Constants {
    static let gameTime: Int = 300
    
    static let playerJumpXMultiplier: Double = 250
    static let playerJumpYMultiplier: Double = 680
    static let playerMass: Double = 0.6
    static let charactersCollisionMask: UInt32 = 1
    
    
    static let playerVelocity: Double = 400
    static let catcherVelocity: Double = 460
    static let playerWidth: Double = 123
    static let playerHeight: Double = 123  * 0.6
    static let catcherHeight: Double = 216
    static let catcherWidth: Double = 150
    
    //player frames count
    static let playerFallFramesCount: Int = 7
    static let playerJumpFramesCount: Int = 7
    static let playerIdleFramesCount: Int = 7
    static let playerRunFramesCount: Int = 8
    static let playerArrestedFramesCount: Int = 22
    static let playerFramesPrefix: String = "caramelo"
    
    //catcher frames count
    static let catcherFallFramesCount: Int = 4
    static let catcherJumpFramesCount: Int = 7
    static let catcherIdleFramesCount: Int = 2
    static let catcherRunFramesCount: Int = 8
    static let catcherFramesPrefix: String = "catcher"

    //Camera distance
    static let scaleFactorY: Double = 1.75
    static let scaleFactorX: Double = 1.75
    static let respawnCount: Int = 4
    
    //tasks timers
    static let timerForThrTaskBeAvaiableAgain: Int = 15
    static let timerTask1BeAvaiable: Int = 25
    static let timerTask2BeAvaiable: Int = 30
    static let timerTask3BeAvaiable: Int = 35
    
    //tasks per player
    static let numberOfTasksThatTheDogsNeedToBeAdopted: Int = 1
}
