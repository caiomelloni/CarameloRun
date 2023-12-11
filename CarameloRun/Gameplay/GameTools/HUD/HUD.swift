//
//  HUD.swift
//  CarameloRun
//
//  Created by Marcelo Pastana Duarte on 05/12/23.
//

import SpriteKit
import GameplayKit

class HUD {
    var hudNode: SKNode
    var width: Double
    var height: Double
    var timer = ControllTimer()
    var players: [Player]
    var avatars = [Avatar]()
    var progressBar = ProgressBar(progressBarImage: "progress_bar_fill", progressBarStroke: "progress_bar_stroke", taskTotal: Constants.numberOfTasksThatTheDogsNeedToBeAdopted, taskDone: 0)
//    var sceneFrame:

    init(hudNode: SKSpriteNode = SKSpriteNode(), width: Double, height: Double, players: [Player]) {
        self.hudNode = hudNode
        self.width = width
        self.height = height
        self.players = players


        hudNode.size = CGSize(width: width * Constants.scaleFactorY , height: height/5)
        hudNode.zPosition = Zposition.hud.rawValue

        hudNode.addChild(timer.node)
        timer.node.position = CGPoint(x: hudNode.position.x - height/6, y: 0)
        hudNode.addChild(progressBar.progressNode)
        insertAvatars()



    }

    private func insertAvatars() {
        for player in players {
            let avatar: Avatar
            if player.type == .man {
                avatar = Avatar(playerName: player.displayName, playerType: player.type)

            }
            else {
                var dogState: dogMatchState
                let playerEntity = player as GKEntity
                let playerState = playerEntity.component(ofType: PlayerStateComponent.self)?.currentStateType
                dogState = .fullLife
                if  playerState == .arrestState {
                    dogState = .arrested
                } else if playerState == .deadState{
                    dogState = .catched
                }
                let dogColors: [dogPlayerColor] = [.blue, .green, .pink, .red, .yellow]
                avatar = Avatar(playerName: player.displayName, playerType: player.type, dogColor: dogColors[player.playerNumber], dogState: dogState)
            }
            avatar.avatarNode.position = CGPoint(x: Int((timer.node.size.width/1.2)) * (player.playerNumber), y: 0)
            avatars.append(avatar)
            hudNode.addChild(avatar.avatarNode)
        }
    }

    private func removeAvatars() {
        for avatar in avatars {
            avatar.avatarNode.removeFromParent()
        }
        avatars.removeAll()
    }

    private func updateAvatars(_ allPlayers: [Player]) {
        self.players = allPlayers
        removeAvatars()
        insertAvatars()
    }

    private func position(x: Double, y: Double) {
        hudNode.position = CGPoint(x: x - (self.width/2), y: y + (self.height * 1.1))
    }

    private func updateProgressBar(_ numberOfTasksDone: Int) {
        progressBar.progressNode.removeFromParent()
        progressBar = ProgressBar(progressBarImage: "progress_bar_fill", progressBarStroke: "progress_bar_stroke", taskTotal: Constants.numberOfTasksThatTheDogsNeedToBeAdopted, taskDone: numberOfTasksDone)
        hudNode.addChild(progressBar.progressNode)
    }

    func update(_ camera: SKCameraNode, _ frame: CGRect, _ allPlayers: [Player], _ numberOfTasksCompleted: Int) {
        updateAvatars(allPlayers)
        updateProgressBar(numberOfTasksCompleted)
        position(x: camera.position.x + frame.maxX,
                 y: camera.position.y - frame.maxY)
    }
}
