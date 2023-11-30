
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
    let buttonImReady = UIButton(type: .system)
    var controllerDelegate: GameControllerDelegate?
    var timer = ControllTimer()
    let lobbyHelper = LobbyHelper()
    var lobbyPlayers = [LobbyPlayer]()
    var horizontalStackViewPlayers = UIStackView()
    var minFontSize = 100.0
    
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
        
        buttonImReady.isEnabled = true
        
        //Handles match making logic
        lobbyHelper.initLobby(match)
        //==================
        
        view.backgroundColor = UIColor(red: 232.0/255.0, green: 214.0/255.0, blue: 166.0/255.0, alpha: 1.0)
        
        view.addSubview(buttonImReady)
        configureImReadyButton()
        
    }
    
    func configureStackView(players:[LobbyPlayer]) {
        horizontalStackViewPlayers.removeFromSuperview()
        horizontalStackViewPlayers = UIStackView()
        horizontalStackViewPlayers.axis = .horizontal
        horizontalStackViewPlayers.distribution = .fillEqually
        horizontalStackViewPlayers.spacing = 0
        
        let screenWidth = UIScreen.main.bounds.width
        let stackViewWidth = screenWidth * 0.9
        
        horizontalStackViewPlayers.frame = CGRect(x: (screenWidth - stackViewWidth) / 2, y: (UIScreen.main.bounds.height / 2) - 120, width: stackViewWidth, height: 150)
        
        for i in 0...(players.count - 1){
            
            let playerImage = players[i].photo
            
            let imageViewPlayer = UIImageView()
            imageViewPlayer.image = playerImage
            imageViewPlayer.contentMode = .scaleAspectFit
            
            let playerNameLabel = UILabel()
            var fontSize = 0.0
            
            playerNameLabel.text = "\(players[i].displayName)"
            playerNameLabel.textAlignment = .center
            playerNameLabel.adjustsFontSizeToFitWidth = true
            
            playerNameLabel.numberOfLines = 1
            playerNameLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            
            fontSize = playerNameLabel.font.pointSize
            
            if fontSize < minFontSize {
                minFontSize = fontSize
            }
            
        }
        
        print("minFontSize: \(minFontSize)")
        
        for i in 0...(players.count - 1){
            
            let playerImage = players[i].photo
            
            let imageView = UIImageView()
            imageView.image = playerImage
            imageView.contentMode = .scaleAspectFit
            
            let playerNameLabel = UILabel()
            
            
            playerNameLabel.text = "\(players[i].displayName)"
            playerNameLabel.textAlignment = .center
            playerNameLabel.font = .boldSystemFont(ofSize: minFontSize)
            playerNameLabel.textColor = UIColor(red: 32.0/255.0, green: 46.0/255.0, blue: 55.0/255.0, alpha: 1.0)
            playerNameLabel.alpha = 1.0
            playerNameLabel.numberOfLines = 1
            playerNameLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            
            let playerTypeLabel = UILabel()
            
            if players[i].playerType == .man {
                playerTypeLabel.text = "Zé Cadelo"
            } else {
                playerTypeLabel.text = "Caramelo"
                
            }
            
            playerTypeLabel.textAlignment = .center
            
            playerTypeLabel.font = UIFont(name: "Crang", size: 16)
            
            if players[i].ready {
                playerTypeLabel.textColor = UIColor(red: 57.0/255.0, green: 103.0/255.0, blue: 41.0/255.0, alpha: 1.0)
            } else {
                playerTypeLabel.textColor = UIColor(red: 215.0/255.0, green: 94.0/255.0, blue: 64.0/255.0, alpha: 1.0)
                
            }
            playerTypeLabel.alpha = 1.0
            playerTypeLabel.numberOfLines = 1
            playerTypeLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            
            let verticalStackView = UIStackView(arrangedSubviews: [imageView, playerNameLabel, playerTypeLabel])
            verticalStackView.axis = .vertical
            verticalStackView.alignment = .center
            verticalStackView.spacing = 8
            
            horizontalStackViewPlayers.addArrangedSubview(verticalStackView)
        }
        view.addSubview(horizontalStackViewPlayers)
    }
    
    
    func configureImReadyButton() {
        
        let screenWidth = UIScreen.main.bounds.width
        let buttonWidth: CGFloat = 248 // Largura do botão
        let xCoordinate = screenWidth / 2 - buttonWidth/2
        let screenHeight = UIScreen.main.bounds.height
        let buttonHeight: CGFloat = 56 // Largura do botão
        let yCoordinate = (screenHeight - 1.5*buttonHeight)
        
        buttonImReady.layer.borderWidth = 1.5
        buttonImReady.layer.borderColor = UIColor.black.cgColor
        
        buttonImReady.setTitle("Estou pronto!", for: .normal)
        buttonImReady.frame = CGRect(x: xCoordinate, y: yCoordinate, width: buttonWidth, height: 56)
        buttonImReady.setTitleColor(UIColor.white, for: .normal) // Defina a cor do texto como branca
        buttonImReady.addTarget(self, action: #selector(ImReadyButtonTapped), for: .touchUpInside)
        buttonImReady.backgroundColor = UIColor(_colorLiteralRed: 215.0/255.0, green: 94.0/255.0, blue: 64.0/255.0, alpha: 0.5) // Defina a cor de fundo como laranja
        buttonImReady.titleLabel?.font = UIFont(name: "Crang", size: 16)
        
    }
    
    @objc func ImReadyButtonTapped() {
        
        guard buttonImReady.isEnabled else {
            // O botao esta desativado, nada acontece
            return
        }
        
        lobbyHelper.getReadyToPlay()
    }
    
    func allReadyToStartGame(_ players: [LobbyPlayer]) {
        self.navigationController?.isNavigationBarHidden = true
        //TODO: fazer subtituicao de telas ao inves de dar um push
        self.navigationController?.pushViewController(GameViewController(match: match, players: players, time: timer.n), animated: false)
    }
    
}

extension PreparingViewController: LobbyHelperDelegate {
    func allPlayersAreReadyToPlay(_ players: [LobbyPlayer]) {
        allReadyToStartGame(players)
    }
    
    func lobbyPlayersDidChange(_ players: [LobbyPlayer]) {
        configureStackView(players: players)
    }
    
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        lobbyHelper.receivedData(match, data, player)
    }
}
