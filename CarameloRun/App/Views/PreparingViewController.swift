
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
    var definingCatcher: IsCatcher
    var numberOfPlayers: Int = 0
    var playerCatcher: Int = 0
    var timer = ControllTimer()
    var catcherInformationShared = false
    
    var catchersName: String = ""
    
    init(match: GKMatch, prep: PreparingPlayres, definingCatcher: IsCatcher) {
        self.match = match
        self.prep = prep
        self.definingCatcher = definingCatcher
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // configureButton()
        
        button.isEnabled = false
        
        Task{
            players = await getAllPlayers()
            if GKLocalPlayer.local.displayName == players[1].displayName {
                execute()
            }
        }
        
        view.backgroundColor = UIColor(red: 232.0/255.0, green: 214.0/255.0, blue: 166.0/255.0, alpha: 1.0)
        view.addSubview(button)
        match.delegate = self

    }
        
    func execute() {
        Task {
            players = await getAllPlayers()
            await MainActor.run {
                    numberOfPlayers = players.count
                    playerCatcher = sort(players)
                    definePrep(players, playerCatcher)
                    configureStackView(players:players)
                    configureButton()
                    
                    button.isEnabled = true
                    
                    if button.isEnabled {
                        button.backgroundColor = UIColor(_colorLiteralRed: 215.0/255.0, green: 94.0/255.0, blue: 64.0/255.0, alpha: 1.0) // Defina a cor de fundo como laranja
                    }
            }
        }
    }
    
    

    
    func configureStackView(players:[Player]) {
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 24
        
        let screenWidth = UIScreen.main.bounds.width
        let stackViewWidth = screenWidth * 0.8
        
        
        stackView.frame = CGRect(x: (screenWidth - stackViewWidth) / 2, y: (UIScreen.main.bounds.height / 2) - 120, width: stackViewWidth, height: 150)

        for i in 0...(players.count - 1){
            
            let playerImage = players[i].photo
            
            let imageView = UIImageView()
            imageView.image = playerImage
            imageView.contentMode = .scaleAspectFit
            
            let playerNameLabel = UILabel()
          
            
            
            playerNameLabel.text = "\(players[i].displayName)"
            playerNameLabel.textAlignment = .center
            playerNameLabel.font = .boldSystemFont(ofSize: 20)
            playerNameLabel.textColor = UIColor(red: 32.0/255.0, green: 46.0/255.0, blue: 55.0/255.0, alpha: 1.0)
            playerNameLabel.alpha = 1.0
            playerNameLabel.numberOfLines = 2
            playerNameLabel.setContentCompressionResistancePriority(.required, for: .vertical)

            let playerTypeLabel = UILabel()
            
            if players[i].displayName == catchersName {
                players[i].type = .man
                playerTypeLabel.text = "Zé Cadelo"
            } else {
                playerTypeLabel.text = "Caramelo"

            }
            
            playerTypeLabel.textAlignment = .center
            playerTypeLabel.font = .boldSystemFont(ofSize: 20)
            playerTypeLabel.textColor = UIColor(red: 215.0/255.0, green: 94.0/255.0, blue: 64.0/255.0, alpha: 1.0)
            playerTypeLabel.alpha = 1.0
            playerTypeLabel.numberOfLines = 2
            playerTypeLabel.setContentCompressionResistancePriority(.required, for: .vertical)
                        
            let verticalStackView = UIStackView(arrangedSubviews: [imageView, playerNameLabel, playerTypeLabel])
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
            button.backgroundColor = UIColor(_colorLiteralRed: 215.0/255.0, green: 94.0/255.0, blue: 64.0/255.0, alpha: 0.5) // Defina a cor de fundo como laranja
            button.titleLabel?.font = UIFont(name: "Crang", size: 16)
            
        }
    
    @objc func buttonTapped() {
        
        guard button.isEnabled else {
            // O botao esta desativado, nada acontece
            return
        }
        
        prep.name = GKLocalPlayer.local.displayName
        prep.ready = true
        
        sendPreparingPlayers(prep)
        allReady(prep)
    }
    
    func allReady(_ state: PreparingPlayres) {
        
        guard players.count == numberOfPlayers else {
            let alert = UIAlertController(title: "OOps!", message: "Number of players not the expected one", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
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
  
        guard players.count == numberOfPlayers else {
            let alert = UIAlertController(title: "OOps!",
                                          message: "Not enought palyers!",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if GKLocalPlayer.local.displayName == players[1].displayName{
            
            definingCatcher.name = players[n].displayName
            definingCatcher.catcher = n
            players[n].type = .man
            catchersName = players[n].displayName
            shareTypeOfPlayers(definingCatcher)
        
        }
    
    }
    
   
}


extension PreparingViewController: GKMatchDelegate{
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        
        let dataJsonString = String(decoding: data, as: UTF8.self)
        
        let jsonData = dataJsonString.data(using: .utf8)!
        
        do {
            if let preparingPlayers = try? JSONDecoder().decode(PreparingPlayres.self, from: jsonData) {
                allReady(preparingPlayers) //Se os dados podem ser decodificados como uma instância de PreparingPlayres, chama a função allReady(preparingPlayers).
            } else if let definedCatcher = try? JSONDecoder().decode(IsCatcher.self, from: jsonData) { //Se os dados não puderem ser decodificados como PreparingPlayres mas puderem ser decodificados como IsCatcher, realiza algumas operações adicionais.
                catchersName = definedCatcher.name // ele atribui o nome de usuário "sorteado"em definprep para cumprir a função de zé cadelo à variável catchersname
                execute()
            }
        }
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
    
    func shareTypeOfPlayers(_ state: IsCatcher) {
        do {
            let data = try JSONEncoder().encode(state)
            try match.sendData(toAllPlayers: data, with: .reliable)
        } catch {
            print("error sending data")
        }
    }
    
    func getAllPlayers() async -> [Player] {
        
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
