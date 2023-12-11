//
//  HUD.swift
//  CarameloRun
//
//  Created by Marcelo Pastana Duarte on 05/12/23.
//

import SpriteKit

class HUD {
    var hudNode: SKNode
    var width: Double
    var height: Double
    var timer = ControllTimer()
    var players: [LocalPlayer?]
    var progressBar = ProgressBar(progressBarImage: "progress_bar_fill", progressBarStroke: "progress_bar_stroke", taskTotal: 6, taskDone: 3)
//    var sceneFrame:

    init(hudNode: SKSpriteNode = SKSpriteNode(), width: Double, height: Double, players: [LocalPlayer?]) {
        self.hudNode = hudNode
        self.width = width
        self.height = height
        self.players = players


        hudNode.size = CGSize(width: width * Constants.scaleFactorY , height: height/5)
        hudNode.zPosition = Zposition.hud.rawValue

        hudNode.addChild(timer.node)
        timer.node.position = CGPoint(x: hudNode.position.x - height/6, y: 0)
        hudNode.addChild(progressBar.progressNode)

        for player in players {
            let avatar: Avatar
            if player?.type == .man {
                avatar = Avatar(playerName: player?.displayName ?? "", playerType: player?.type ?? .man)
            }
            else {
                var dogState: dogMatchState
                if player?.component(ofType: HealthComponent.self)?.getHealthPoints == 2 {
                    dogState = .fullLife
                } else if player?.component(ofType: HealthComponent.self)?.getHealthPoints == 1 {

                    dogState = .halfLife

                    if player?.component(ofType: PlayerStateComponent.self)?.currentStateType == .arrestState {
                        dogState = .arrested
                    }

                } else {
                    dogState = .catched
                }
                let dogColors: [dogPlayerColor] = [.blue, .green, .pink, .red, .yellow]
                avatar = Avatar(playerName: player?.displayName ?? "", playerType: player?.type ?? .dog, dogColor: dogColors[player?.playerNumber ?? 0], dogState: dogState)
            }
            avatar.avatarNode.position = CGPoint(x: Int((timer.node.size.width/1.2)) * (player?.playerNumber ?? 1), y: 0)
            hudNode.addChild(avatar.avatarNode)
        }


    }

    private func position(x: Double, y: Double) {
        hudNode.position = CGPoint(x: x - (self.width/2), y: y + (self.height * 1.1))
    }

    func update(_ camera: SKCameraNode, _ frame: CGRect) {
        position(x: camera.position.x + frame.maxX,
                 y: camera.position.y - frame.maxY)
    }
}
