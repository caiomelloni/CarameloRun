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
    var players: [LobbyPlayer]
    
    var timer: Timer!
    var time: Int
    
    var score: Int = 0
    
    var controllerFinishGame: Int = 0
    
    init(match: GKMatch, players: [LobbyPlayer], time: Int) {
        self.match = match
        self.players = players
        self.time = time
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
            
            initTimer()
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
    
    private func initTimer() {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                self.time -= 1
                
                if self.time == 0 {
                    self.sendMatchState(MatchState.init(finish: true))
                    self.finishGame()
                    timer.invalidate()
                }
                
                self.gameScene?.timer.updateTimer(self.time)
            })
        }
        
        func finishGame() {
            if controllerFinishGame == 0{
//                match.finalize()
                score = gameScene?.getScore() ?? 0
                if score < 0 {
                    score = 0
                }
                
                let victory = gameScene?.getVictory() ?? false
                
                self.navigationController?.pushViewController(EndGame(score, GKLocalPlayer.local.displayName, victory, gameScene?.entityManager.localPlayer?.type ?? .dog), animated: true)
                
                controllerFinishGame = 1
            }
        }
    }


extension GameViewController: GKMatchDelegate {
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        let dataJsonString = String(decoding: data, as: UTF8.self)
        let jsonData = dataJsonString.data(using: .utf8)!
        
        gameScene?.didReceiveData(match, data, player)
        
        do {
           if let matchState = try? JSONDecoder().decode(MatchState.self, from: jsonData) {
                if matchState.finish {
                    finishGame()
                }
            } else if let tasks = try? JSONDecoder().decode(taskDone.self, from: jsonData) {
                if tasks.done == true {
                    addOneTaskDone(tasks.frameOfTheTask)
                }
            } else {
                print("Error reciving data")
            }
        }
    }
}

protocol GameControllerDelegate {
    var players: [LobbyPlayer] { get }
    func finishGame()
    var match: GKMatch { get }
    func sendTaskDone(_ state: taskDone)
    func addOneTaskDone(_ frame: CGRect)
}

extension GameViewController: GameControllerDelegate {
    
    func sendPlayerState(_ state: PlayerData) {
        
        do {
            let data = try JSONEncoder().encode(state)
            try match.sendData(toAllPlayers: data, with: GKMatch.SendDataMode.unreliable)
        } catch {
            print("error sending data")
        }
    }
    
    func sendMatchState(_ state: MatchState) {
        do {
            let data = try JSONEncoder().encode(state)
            try match.sendData(toAllPlayers: data, with: GKMatch.SendDataMode.unreliable)
        } catch {
            print("error sending data")
        }
    }
    
    func sendTaskDone(_ state: taskDone) {
        do {
            let data = try JSONEncoder().encode(state)
            try match.sendData(toAllPlayers: data, with: GKMatch.SendDataMode.unreliable)
        } catch {
            print("error sending data")
        }
    }
    
    func addOneTaskDone(_ frame: CGRect) {
        if frame == gameScene?.task1.frame {
            gameScene?.addToGeneral((gameScene?.task1)!)
        } else if frame == gameScene?.task2.frame {
            gameScene?.addToGeneral((gameScene?.task2)!)
        } else if frame == gameScene?.task3.frame {
            gameScene?.addToGeneral((gameScene?.task2)!)
        }
    }
    
}

enum GameState {
    case playerState(PlayerState)
    case matchState(MatchState)
}
