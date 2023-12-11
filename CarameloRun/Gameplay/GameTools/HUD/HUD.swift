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
    var progressBar = ProgressBar(progressBarImage: "progress_bar_fill", progressBarStroke: "progress_bar_stroke", taskTotal: 5, taskDone: 1)
//    var sceneFrame:

    init(hudNode: SKSpriteNode = SKSpriteNode(), width: Double, height: Double, players: [LocalPlayer?]) {
        self.hudNode = hudNode
        self.width = width
        self.height = height
        self.players = players
        for player in players {
            print(player)
        }
        let avatar1 = Avatar(playerName: "NudeDoJoshuaMatheus", playerType: .man)
        let avatar2 = Avatar(playerName: "JoshuaMatheusNudeDo", playerType: .dog, dogColor: .blue, dogState: .fullLife)
        let avatar3 = Avatar(playerName: "NudeDoJoshuaMatheus", playerType: .dog, dogColor: .green, dogState: .arrested)
        let avatar4 = Avatar(playerName: "NudeDoJoshuaMatheus", playerType: .dog, dogColor: .red, dogState: .catched)
        let avatar5 = Avatar(playerName: "NudeDoJoshuaMatheus", playerType: .dog, dogColor: .yellow, dogState: .halfLife)
        let avatar6 = Avatar(playerName: "NudeDoJoshuaMatheus", playerType: .dog, dogColor: .pink, dogState: .fullLife)

        hudNode.size = CGSize(width: width * Constants.scaleFactorY , height: height/5)
//        hudNode.color = SKColor.systemGray2
        hudNode.zPosition = Zposition.hud.rawValue

        hudNode.addChild(timer.node)
        timer.node.position = CGPoint(x: hudNode.position.x - height/6, y: 0)
        hudNode.addChild(progressBar.progressNode)

        hudNode.addChild(avatar1.avatarNode)
        hudNode.addChild(avatar2.avatarNode)
        hudNode.addChild(avatar3.avatarNode)
        hudNode.addChild(avatar4.avatarNode)
        hudNode.addChild(avatar5.avatarNode)
        hudNode.addChild(avatar6.avatarNode)

        avatar1.avatarNode.position = CGPoint(x: timer.node.size.width/1.2, y: 0)
        avatar2.avatarNode.position = CGPoint(x: 2 * timer.node.size.width/1.2, y: 0)
        avatar3.avatarNode.position = CGPoint(x: 3 * timer.node.size.width/1.2, y: 0)
        avatar4.avatarNode.position = CGPoint(x: 4 * timer.node.size.width/1.2, y: 0)
        avatar5.avatarNode.position = CGPoint(x: 5 * timer.node.size.width/1.2, y: 0)
        avatar6.avatarNode.position = CGPoint(x: 6 * timer.node.size.width/1.2, y: 0)


    }

    private func position(x: Double, y: Double) {
        hudNode.position = CGPoint(x: x - (self.width/2), y: y + (self.height * 1.1))
    }

    func update(_ camera: SKCameraNode, _ frame: CGRect) {
        position(x: camera.position.x + frame.maxX,
                 y: camera.position.y - frame.maxY)
    }
}
