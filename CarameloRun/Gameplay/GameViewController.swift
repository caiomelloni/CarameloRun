//
//  GameViewController.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 28/09/23.
//

import UIKit
import SpriteKit
import GameplayKit
import GameKit

class GameViewController: UIViewController {
    
    var match: GKMatch
    var gameScene: GameScene?
    var players: [Player]
    
    init(match: GKMatch, players: [Player]) {
        self.match = match
        self.players = players
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = SKView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = GameScene(fileNamed: "Background") {
                gameScene = scene
                
                scene.controllerDelegate = self
                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
    
            view.ignoresSiblingOrder = true
            view.isMultipleTouchEnabled = true
            view.showsFPS = true
            view.preferredFramesPerSecond = 30
            view.showsNodeCount = true
        }
        
        match.delegate = self
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscape
        } else {
            return .landscape
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GameViewController: GKMatchDelegate {
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        let dataJsonString = String(decoding: data, as: UTF8.self)
        //print(dataJsonString)
        
        let jsonData = dataJsonString.data(using: .utf8)!
        let playerState: PlayerState = try! JSONDecoder().decode(PlayerState.self, from: jsonData)
        
        gameScene?.updatePlayersPosition(playerState)
    }
}

protocol GameControllerDelegate {
    func sendPlayerState(_ state: PlayerState)
    var players: [Player] { get }
}

extension GameViewController: GameControllerDelegate {
    
    func sendPlayerState(_ state: PlayerState) {
        do {
            let data = try JSONEncoder().encode(state)
            try match.sendData(toAllPlayers: data, with: GKMatch.SendDataMode.unreliable)
        } catch {
            print("error sending data")
        }
    }
}
