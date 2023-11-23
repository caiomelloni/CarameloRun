
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
    let button = UIButton(type: .system)
    var controllerDelegate: GameControllerDelegate?
    var players: [LobbyPlayer] = []
    var timer = ControllTimer()
    let lobbyHelper = LobbyHelper()
    var lobbyPlayers = [LobbyPlayer]()
    var stackView = UIStackView()
    
    init(match: GKMatch) {
        self.match = match
        super.init(nibName: nil, bundle: nil)
        lobbyHelper.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.isEnabled = true
        
        //Game center logic
        match.delegate = self
        lobbyHelper.initLobby(match)
        //==================
        
        view.backgroundColor = UIColor(red: 232.0/255.0, green: 214.0/255.0, blue: 166.0/255.0, alpha: 1.0)
        
        view.addSubview(button)
        configureButton()
        
    }
    
    func configureStackView(players:[LobbyPlayer]) {
        self.stackView.removeFromSuperview()
        self.stackView = UIStackView()
        let stackView = stackView
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 24
        
        let screenWidth = UIScreen.main.bounds.width
        let stackViewWidth = screenWidth * 0.8
        
        
        stackView.frame = CGRect(x: (screenWidth - stackViewWidth) / 2, y: (UIScreen.main.bounds.height / 2) - 120, width: stackViewWidth, height: 150)
        
        if players.count == 0 {
            return
        }
        
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
            
            if players[i].playerType == .man {
                playerTypeLabel.text = "Zé Cadelo"
            } else {
                playerTypeLabel.text = "Caramelo"
            }
            playerTypeLabel.text = playerTypeLabel.text! + " \(players[i].ready ? "pronto" : "")"
            
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
                
        lobbyHelper.getReadyToPlay(match)
    }
    
    func allReady(_ players: [LobbyPlayer]) {
        var allPlayersAreReady = true
        for player in players {
            if !player.ready {
                allPlayersAreReady = false
                break
            }
        }
        
        if allPlayersAreReady  {
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.popViewController(animated: true)
            self.navigationController?.pushViewController(GameViewController(match: match, players: players, time: timer.n), animated: true)
        }
    }
    
}

extension PreparingViewController: LobbyHelperDelegate {
    func lobbyPlayersDidChange(_ players: [LobbyPlayer]) {
        allReady(players)
        configureStackView(players: players)
    }
}
