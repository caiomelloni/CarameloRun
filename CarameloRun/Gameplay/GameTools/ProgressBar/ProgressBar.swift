//
//  ProgressBar.swift
//  CarameloRun
//
//  Created by Marcelo Pastana Duarte on 01/12/23.
//

import Foundation
import SpriteKit

class ProgressBar {
    var progressBarImage: String
    var progressBarStroke: String
    var taskDone: Int
    var progressNode: SKSpriteNode = SKSpriteNode()

    init(progressBarImage: String, progressBarStroke: String, taskDone: Int) {
        self.progressBarImage = progressBarImage
        self.progressBarStroke = progressBarStroke
        self.taskDone = taskDone

        let progressBarImage = self.progressBarImage(image: progressBarImage,
                                           stroke: progressBarStroke,
                                           taskDone: taskDone)

        let taskCounter = taskCounter(taskDone: taskDone, taskTotal: 5)

        progressBarImage.addChild(taskCounter)

        taskCounter.position = CGPoint(x: 0, y: -(Constants.scaleFactorX * 96 )/8)
        self.progressNode.addChild(progressBarImage)
    }

    func progressBarImage(image: String, stroke: String, taskDone: Int) -> SKSpriteNode {

        let progressImage: UIImage = UIImage(named: image) ?? UIImage()
        let progressImageNode: SKSpriteNode = SKSpriteNode(texture: SKTexture(image: progressImage), 
                                                           size: CGSize(width: 384 * Constants.scaleFactorX, height: 96 * Constants.scaleFactorX))
        progressImageNode.zPosition = Zposition.hud.rawValue + 1

//        let mask = SKSpriteNode(color: .black, size: CGSize(width: progressImageNode.size.width, height: progressImageNode.size.height))

        let rectangle: SKShapeNode = SKShapeNode(rectOf: CGSize(width: 100, height: progressImageNode.size.height))
        print(rectangle.position)

        rectangle.fillColor = .black
        rectangle.alpha = 1
        rectangle.blendMode = .replace

//        mask.addChild(rectangle)


        let crop = SKCropNode()
        crop.maskNode = rectangle
        crop.zPosition = Zposition.hud.rawValue + 2
        crop.addChild(progressImageNode)

        let progressStroke: UIImage = UIImage(named: stroke) ?? UIImage()
        let progressStrokeNode: SKSpriteNode = SKSpriteNode(texture: SKTexture(image: progressStroke),
                                                            size: CGSize(width: 384 * Constants.scaleFactorX, height: 96 * Constants.scaleFactorX))

        let progressBar: SKSpriteNode = SKSpriteNode()
        progressBar.addChild(progressStrokeNode)
        progressBar.addChild(crop)
        progressBar.position = CGPoint(x: Int(3.5 * -Double(Dimensions.buttonWidth.rawValue)), y: 0)


        return progressBar

    }

    func taskCounter(taskDone: Int, taskTotal: Int) -> SKLabelNode {
        let counter = SKLabelNode(fontNamed: "Crang")
        counter.text = "\(taskDone)/\(taskTotal)"
        counter.fontSize = 48
        counter.fontColor = .black
        counter.zPosition = Zposition.hud.rawValue + 3
        return counter
    }



    
}
