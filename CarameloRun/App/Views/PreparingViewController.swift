
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
        
        view.backgroundColor = ColorsConstants.backgroundColor
        
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
        
        for player in players{
            
            let playerImage = player.photo
            
            let playerTypeLabel = UILabel()
            
            let imageViewPlayer = UIImageView()
            
            imageViewPlayer.image = playerImage
            imageViewPlayer.contentMode = .scaleAspectFit
            
            let playerNameLabel = UILabel()
            var fontSize = 0.0
            
            playerNameLabel.text = "\(player.displayName)"
            playerNameLabel.textAlignment = .center
            playerNameLabel.adjustsFontSizeToFitWidth = true
            playerNameLabel.numberOfLines = 1
            playerNameLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            playerNameLabel.textColor = ColorsConstants.textColor
            playerNameLabel.alpha = 1.0
            playerNameLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
            fontSize = playerNameLabel.font.pointSize
        
            if fontSize < minFontSize {
                minFontSize = fontSize
            }
            
            playerNameLabel.font = .boldSystemFont(ofSize: minFontSize)
            
            if player.playerType == .man {
                playerTypeLabel.text = PreparingViewControllerStrings.ManTypePlayer.localized()
            } else {
                playerTypeLabel.text = PreparingViewControllerStrings.DogTypePlayer.localized()
                
            }
            
            playerTypeLabel.textAlignment = .center
            playerTypeLabel.font = Fonts.subTitleFont
            playerTypeLabel.alpha = 1.0
            playerTypeLabel.numberOfLines = 1
            playerTypeLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            
            if player.ready {
                playerTypeLabel.textColor = ColorsConstants.connectedColor
            } else {
                playerTypeLabel.textColor = ColorsConstants.tittlesColor
            }
            
            let verticalStackView = UIStackView(arrangedSubviews: [imageViewPlayer, playerNameLabel, playerTypeLabel])
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
        
        buttonImReady.setTitle(PreparingViewControllerStrings.ButtonTitleText.localized(), for: .normal)
        buttonImReady.frame = CGRect(x: xCoordinate, y: yCoordinate, width: buttonWidth, height: 56)
        buttonImReady.setTitleColor(UIColor.white, for: .normal) // Defina a cor do texto como branca
        buttonImReady.addTarget(self, action: #selector(ImReadyButtonTapped), for: .touchUpInside)
        buttonImReady.backgroundColor = ColorsConstants.buttonColor
        buttonImReady.titleLabel?.font = Fonts.subTitleFont
        
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
