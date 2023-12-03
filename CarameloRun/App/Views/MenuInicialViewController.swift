
//
//  MenuInicial.swift
//  CarameloRun
//
//  Created by Caio Melloni dos Santos on 19/10/23.
//

import Foundation
import UIKit
import GameKit

class MenuInicialViewController: UIViewController {
    let stackViewMenuInicial = UIStackView()
    let logoImageView = UIImageView(image: Images.logoImage)
    let helpButtonImage = Images.helpButtonImage
    let helpButton = UIButton(type: UIButton.ButtonType.custom)
    let startButtonImage = Images.startButtonImage
    let startButton = UIButton(type: UIButton.ButtonType.custom)
    let gameCenterHelper = GameCenterHelper()
    let connectionStatusLabel = UILabel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.isEnabled = false
        
        configureButtons()
        configureStackView()
        setStackViewConstraints()
        setButtonsContraints()
        gameCenterHelper.delegate = self
        gameCenterHelper.authenticatePlayer()
        self.view.backgroundColor = ColorsConstants.menuBackgroundImage

    }
}

extension MenuInicialViewController {
    
    
    
    func configureButtons() {
    
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setImage(startButtonImage, for: .normal)
        startButton.addTarget(self, action: #selector(initGame), for: .touchUpInside)
        
        helpButton.translatesAutoresizingMaskIntoConstraints = false
        helpButton.setImage(helpButtonImage, for: .normal)
        helpButton.addTarget(self, action: #selector(showHelpPopUp), for: .touchUpInside)
      
    }
    
    func configureStackView() {
        view.addSubview(stackViewMenuInicial)
        stackViewMenuInicial.axis = .vertical
        stackViewMenuInicial.spacing = 24
        stackViewMenuInicial.alignment = .center
        stackViewMenuInicial.addArrangedSubview(logoImageView)
        stackViewMenuInicial.addArrangedSubview(startButton)
        stackViewMenuInicial.addArrangedSubview(connectionStatusLabel)
    }
    
    func setStackViewConstraints() {
        
        stackViewMenuInicial.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackViewMenuInicial.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewMenuInicial.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setButtonsContraints() {
        view.addSubview(helpButton)
        
        helpButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            helpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            helpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -56)
           
        ])
        
    }
    
    func configureConnectionStatusLabel() {
        connectionStatusLabel.textAlignment = .center
        connectionStatusLabel.numberOfLines = 1
        connectionStatusLabel.text = MenuInicialViewControllerStrings.ConnectionStatusLabelTextNotConnected.localized()
        connectionStatusLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
    }
    
    @objc func initGame() {
        gameCenterHelper.presentMatchmaker()
    }
    
    @objc func showHelpPopUp(){
        let vc = HelpPopUpViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
}


extension MenuInicialViewController: GameCenterHelperDelegate {
  func didChangeAuthStatus(isAuthenticated: Bool) {

    startButton.isEnabled = isAuthenticated
      connectionStatusLabel.text = MenuInicialViewControllerStrings.ConnectionStatusLabelTextConnected.localized()
    connectionStatusLabel.font = UIFont.boldSystemFont(ofSize: 16)
  }
  func presentGameCenterAuth(viewController: UIViewController?) {
    guard let vc = viewController else {return}
    self.present(vc, animated: true)
  }
  func presentMatchmaking(viewController: UIViewController?) {
    guard let vc = viewController else {return}
    self.present(vc, animated: true)
  }
  func presentGame(match: GKMatch) {
      self.navigationController?.isNavigationBarHidden = true
      self.navigationController?.popViewController(animated: true)
      self.navigationController?.pushViewController(PreparingViewController(match: match), animated: true)
      
  }
}
