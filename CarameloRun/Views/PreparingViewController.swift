//
//  Preparing.swift
//  CarameloRun
//
//  Created by Luis Silva on 25/10/23.
//

import Foundation
import UIKit
import GameKit

class PreparingViewController: UIViewController {
    let match: GKMatch
    var player1 = UILabel()
    var player2 = UILabel()
    var player3 = UILabel()
    let button = UIButton(type: .system)
    var controllerDelegate: GameControllerDelegate?
    var players: [Player] = []
    var prep: PreparingPlayres
    
    init(match: GKMatch, prep: PreparingPlayres) {
        self.match = match
        self.prep = prep
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        players = getAllPlayers() 
        players = sort(players)
        definePrep(players)
        
        player1.text = "\(players[0].displayName): \(players[0].type)"
        player1.frame = CGRect(x: 200, y: 100, width: 200, height: 30)
        player2.text = "\(players[1].displayName): \(players[1].type)"
        player2.frame = CGRect(x: 200, y: 150, width: 200, height: 30)
//        player3.text = "\(players[2].displayName): \(players[2].type)"
//        player3.frame = CGRect(x: 200, y: 200, width: 200, height: 30)
        
        view.addSubview(player1)
        view.addSubview(player2)
//        view.addSubview(player3)
        
        button.setTitle("Estou pronto", for: .normal)
        button.frame = CGRect(x: 200, y: 300, width: 200, height: 40)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        view.addSubview(button)
        
        match.delegate = self
    }
    
    @objc func buttonTapped() {
        prep.name = GKLocalPlayer.local.displayName
        prep.ready = true
        print("\(prep.name) está pronto")
        
        sendPreparingPlayers(prep)
        allReady(prep)
    }
    
    func allReady(_ state: PreparingPlayres) {
        for i in 0...1 {
            if state.name == players[i].displayName {
                players[i].ready = state.ready
            }
        }
        
        
        if state.name == players[1].displayName {
            players[0].type = state.type0
            players[1].type = state.type1
//            players[2].type = state.type2
            
            player1.text = "\(players[0].displayName): \(players[0].type)"
            player2.text = "\(players[1].displayName): \(players[1].type)"
//            player3.text = "\(players[2].displayName): \(players[2].type)"
        }
        
        
        if players[0].ready == true && players[1].ready == true {//&& players[2].ready == true {
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.popViewController(animated: true)
            self.navigationController?.pushViewController(GameViewController(match: match, players2: players), animated: true)
        }
    }
    
    func sort(_ players: [Player]) -> [Player]{
        if GKLocalPlayer.local.displayName == players[1].displayName{
            let n = Int.random(in: 0...1)
            switch n {
            case 0:
                players[0].type = .man
                players[1].type = .dog
//                players[2].type = .dog
            case 1:
                players[0].type = .dog
                players[1].type = .man
//                players[2].type = .dog
//            case 2:
//                players[0].type = .dog
//                players[1].type = .dog
//                players[2].type = .man
            default:
                print("Error")
            }
        }
        return players
    }
    
    func definePrep(_ players: [Player]) {
        if GKLocalPlayer.local.displayName == players[1].displayName{
            prep.name = GKLocalPlayer.local.displayName
            prep.type0 = players[0].type
            prep.type1 = players[1].type
//            prep.type2 = players[2].type
            
            sendPreparingPlayers(prep)
        }
    }
}


extension PreparingViewController: GKMatchDelegate{
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        let dataJsonString = String(decoding: data, as: UTF8.self)
        
        let jsonData = dataJsonString.data(using: .utf8)!
        let preparingPlayers: PreparingPlayres = try! JSONDecoder().decode(PreparingPlayres.self, from: jsonData)
        
        allReady(preparingPlayers)
    }
}


protocol PreparingControllerDelegate {
    func sendPreparingPlayers(_ state: PreparingPlayres)
    func getAllPlayers() -> [Player]
}

extension PreparingViewController: PreparingControllerDelegate {
    func sendPreparingPlayers(_ state: PreparingPlayres) {
        print(state)
        do {
            let data = try JSONEncoder().encode(state)
            try match.sendData(toAllPlayers: data, with: GKMatch.SendDataMode.reliable)
        } catch {
            print("error sending data")
        }
    }
    
    func getAllPlayers() -> [Player] {
        let localPlayer = Player(displayName: GKLocalPlayer.local.displayName, playerNumber: 0)
        var players = [localPlayer]
        
        let gameCenterPlayers = match.players
        
        for player in gameCenterPlayers {
            for i in 0..<players.count {
                if player.displayName < players[i].displayName {
                    players.insert(Player(displayName: player.displayName, playerNumber: 0), at: i)
                    break
                }
                
                if i == players.count - 1 {
                    players.append(Player(displayName: player.displayName, playerNumber: 0))
                }
                
            }
        }
        
        for i in 0..<players.count {
            players[i].playerNumber = i + 1
        }
        
        
        return players
        
    }
}
