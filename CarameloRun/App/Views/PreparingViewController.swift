
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
    var listOfPlayerLabels: [UILabel] = []
    let button = UIButton(type: .system)
    var controllerDelegate: GameControllerDelegate?
    var players: [Player] = []
    var prep: PreparingPlayres
    var numberOfPlayers: Int = 0
    var playerCatcher: Int = 0
    var timer = ControllTimer()
    
    init(match: GKMatch, prep: PreparingPlayres) {
        self.match = match
        self.prep = prep
        
        for _ in 0...(match.players.count){
            listOfPlayerLabels.append(UILabel())
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        players = getAllPlayers()
//        players[1].ready = true
        numberOfPlayers = players.count
        playerCatcher = sort(players)
        definePrep(players, playerCatcher)
        
        for i in 0...(numberOfPlayers - 1){
            listOfPlayerLabels[i].text = "\(players[i].displayName): \(players[i].type)"
            listOfPlayerLabels[i].frame = CGRect(x: 200, y: (100+i*50), width: 200, height: 30)
            view.addSubview(listOfPlayerLabels[i])
        }
        
        view.backgroundColor = UIColor(red: 232.0/255.0, green: 214.0/255.0, blue: 166.0/255.0, alpha: 1.0)
        
        button.setTitle("Estou pronto", for: .normal)
        button.frame = CGRect(x: 248, y: 300, width: 248, height: 56)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        view.addSubview(button)
        
        
        match.delegate = self
    }
    
    @objc func buttonTapped() {
        prep.name = GKLocalPlayer.local.displayName
        prep.ready = true
        
        sendPreparingPlayers(prep)
        allReady(prep)
    }
    
    func allReady(_ state: PreparingPlayres) {
        if state.name == players[1].displayName {
            players[state.catcher].type = .man
            
            for i in 0...(numberOfPlayers - 1){
                listOfPlayerLabels[i].text = "\(players[i].displayName): \(players[i].type)"
            }
        }
        
        var counter = 0
        for i in 0...(numberOfPlayers - 1) {
            if state.name == players[i].displayName {
                players[i].ready = state.ready
            }
            
            if players[i].ready == true {
                counter += 1
            }
        }
        
        if counter == numberOfPlayers  {
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.popViewController(animated: true)
            self.navigationController?.pushViewController(GameViewController(match: match, players: players, time: timer.n), animated: true)
        }
    }
    
    func sort(_ players: [Player]) -> Int {
        let n = Int.random(in: 0...(numberOfPlayers - 1))
        if GKLocalPlayer.local.displayName == players[1].displayName{
            players[n].type = .man
        }
        return n
    }
    
    
    func definePrep(_ players: [Player], _ n: Int) {
        if GKLocalPlayer.local.displayName == players[1].displayName{
            prep.name = GKLocalPlayer.local.displayName
            prep.catcher = n
            
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
        do {
            let data = try JSONEncoder().encode(state)
            try match.sendData(toAllPlayers: data, with: .reliable)
        } catch {
            print("error sending data")
        }
    }
    
    func getAllPlayers() -> [Player] {
        let localPlayer = Player(displayName: GKLocalPlayer.local.displayName, playerNumber: 0, playerType: .dog)
        var players = [localPlayer]
        
        let gameCenterPlayers = match.players
        
        for player in gameCenterPlayers {
            for i in 0..<players.count {
                if player.displayName < players[i].displayName {
                    players.insert(Player(displayName: player.displayName, playerNumber: 0, playerType: .dog), at: i)
                    break
                }
                
                if i == players.count - 1 {
                    players.append(Player(displayName: player.displayName, playerNumber: 0, playerType: .dog))
                }
                
            }
        }
        
        for i in 0..<players.count {
            players[i].playerNumber = i + 1
        }
        
        
        return players
        
    }
}
