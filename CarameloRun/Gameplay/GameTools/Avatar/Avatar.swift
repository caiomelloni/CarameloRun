//
//  Avatar.swift
//  CarameloRun
//
//  Created by Marcelo Pastana Duarte on 30/11/23.
//

import SpriteKit

class Avatar {
    var playerName: String
    var playerType: typeOfPlayer
    var dogColor: dogPlayerColor?
    var dogState: dogMatchState?
    var avatarNode: SKSpriteNode = SKSpriteNode()

    init(playerName: String, playerType: typeOfPlayer, dogColor: dogPlayerColor? = nil, dogState: dogMatchState? = nil) {
        self.playerName = playerName
        self.playerType = playerType
        self.dogColor = dogColor
        self.dogState = dogState

        let avatarImageNode = avatarImage(playerType: self.playerType, dogColor: self.dogColor, dogState: self.dogState)
        let nameLabelNode = nameLabel(playerName: playerName)

        nameLabelNode.position = CGPoint(x: avatarImageNode.position.x, y: -avatarImageNode.size.height/1.5)
        avatarNode.addChild(avatarImageNode)
        avatarNode.addChild(nameLabelNode)


    }

    func avatarImage(playerType: typeOfPlayer, dogColor: dogPlayerColor?, dogState: dogMatchState?) -> SKSpriteNode {
        var avatarImageNode: SKSpriteNode = SKSpriteNode()
        avatarImageNode.size = CGSize(width: Dimensions.buttonWidth.rawValue, height: Dimensions.buttonHeight.rawValue)
        avatarImageNode.zPosition = 10
        if playerType == .man {
            avatarImageNode.texture = SKTexture(image: UIImage(named: "avatar_catcher") ?? UIImage())
            return avatarImageNode
        }
        avatarImageNode.texture = SKTexture(image: UIImage(named: "avatar_dog\(dogColor?.rawValue ?? "")_\(dogState?.rawValue ?? "")") ?? UIImage())
        return avatarImageNode
    }

    func nameLabel(playerName: String) -> SKLabelNode {
        var nameLabelNode: SKLabelNode = SKLabelNode(fontNamed: "Crang")
        let slicedPlayerNamed = "\(playerName.prefix(6))\(playerName.count > 6 ? "..." : "")"
        nameLabelNode.text = String(slicedPlayerNamed)
        nameLabelNode.fontColor = .black
        nameLabelNode.fontSize = 21
        return nameLabelNode

    }


}
