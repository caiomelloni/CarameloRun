
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
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        Task {
            players = await getAllPlayers()
            await MainActor.run {
                numberOfPlayers = players.count
                playerCatcher = sort(players)
                definePrep(players, playerCatcher)
                
                configureStackView(players:players)
                
            }
        }
       
//        players[1].ready = true
        
       
        configureButton()
                
        view.backgroundColor = UIColor(red: 232.0/255.0, green: 214.0/255.0, blue: 166.0/255.0, alpha: 1.0)
        
        view.addSubview(button)
        
        match.delegate = self
    }
    
    func configureStackView(players:[Player]) {
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        let screenWidth = UIScreen.main.bounds.width
        let stackViewWidth = screenWidth * 0.8
        stackView.frame = CGRect(x: (screenWidth - stackViewWidth) / 2, y: (UIScreen.main.bounds.height / 2) - 120, width: stackViewWidth, height: 150)

        for i in 0...(players.count - 1){
            
            let playerImage = players[i].photo
            
            let imageView = UIImageView()
            imageView.image = playerImage
            imageView.contentMode = .scaleAspectFit
            
            //let playerLabel = self.listOfPlayerLabels[i]
            
            let playerLabel = UILabel()
            playerLabel.text = "\(players[i].displayName): \(players[i].type)"
            playerLabel.textAlignment = .center
            playerLabel.font = UIFont(name: "Inter", size: 10)
            playerLabel.numberOfLines = 0
                        
            let verticalStackView = UIStackView(arrangedSubviews: [imageView, playerLabel])
            verticalStackView.axis = .vertical
            verticalStackView.alignment = .center
            verticalStackView.spacing = 8
            
            stackView.addArrangedSubview(verticalStackView)
        }
        view.addSubview(stackView)
    }
    
    
    func configureButton() {
            
            let screenWidth = UIScreen.main.bounds.width
            let buttonWidth: CGFloat = 248 // Largura do botão
            let xCoordinate = screenWidth / 2 - buttonWidth/2
            let screenHeight = UIScreen.main.bounds.height
            let buttonHeight: CGFloat = 56 // Largura do botão
        let yCoordinate = (screenHeight - 1.5*buttonHeight)
            
            button.layer.borderWidth = 1.5
            button.layer.borderColor = UIColor.black.cgColor
            
            button.setTitle("Estou pronto!", for: .normal)
            button.frame = CGRect(x: xCoordinate, y: yCoordinate, width: buttonWidth, height: 56)
            button.setTitleColor(UIColor.white, for: .normal) // Defina a cor do texto como branca
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            button.backgroundColor = UIColor(_colorLiteralRed: 215.0/255.0, green: 94.0/255.0, blue: 64.0/255.0, alpha: 1.0) // Defina a cor de fundo como laranja
            button.titleLabel?.font = UIFont(name: "Crang", size: 16)
            
        }
    
    @objc func buttonTapped() {
        prep.name = GKLocalPlayer.local.displayName
        prep.ready = true
        
        sendPreparingPlayers(prep)
        allReady(prep)
    }
    
    func allReady(_ state: PreparingPlayres) {
        
        guard players.count >= 2 else {return}
        
        if state.name == players[1].displayName {
            players[state.catcher].type = .man
            
            for i in 0..<numberOfPlayers{
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
    func getAllPlayers() async -> [Player]
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
    
    func getAllPlayers() async -> [Player] {
        
        //let localPlayer = GKLocalPlayer.local
        
        let localPlayerPhoto: UIImage? = try? await GKLocalPlayer.local.loadPhoto(for: .normal)
        
        let localPlayerInstance = Player(displayName: GKLocalPlayer.local.displayName, playerNumber: 0, playerType: .dog, photo: localPlayerPhoto)
        var players = [localPlayerInstance]
        
        let gameCenterPlayers = match.players
        
        for player in gameCenterPlayers {
            for i in 0..<players.count {
                if player.displayName < players[i].displayName {
                    let remotePlayerPhoto = try? await player.loadPhoto(for: .normal)
                    players.insert(Player(displayName: player.displayName, playerNumber: 0, playerType: .dog, photo: remotePlayerPhoto), at: i)
                    break
                }
                
                if i == players.count - 1 {
                    let remotePlayerPhoto = try? await player.loadPhoto(for: .normal)
                    players.append(Player(displayName: player.displayName, playerNumber: 0, playerType: .dog, photo: remotePlayerPhoto))
                }
            }
        }
        
        for i in 0..<players.count {
            players[i].playerNumber = i + 1
        }
        
        
        return players
        
    }
}
