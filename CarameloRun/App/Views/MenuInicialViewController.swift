
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
    let stackView = UIStackView()
    let logoImageView = UIImageView(image: UIImage(named: "Logo"))
    let helpButtonImage = UIImage(named: "helpButton")
    let helpButton = UIButton(type: UIButton.ButtonType.custom)
    let startButtonImage = UIImage(named: "startButton")
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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundMenu.png")!)

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
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .center
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(startButton)
        stackView.addArrangedSubview(connectionStatusLabel)
    }
    
    func setStackViewConstraints() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
        connectionStatusLabel.text = "You are not connected to Game Center"
        connectionStatusLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        
    }
    
    @objc func initGame() {
        gameCenterHelper.presentMatchmaker()
    }
    
    @objc func showHelpPopUp(){
        let vc = HelpPopUpViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func showCreditsPopUp(){
        let vc = CreditsPopUpViewController()
        self.present(vc, animated: true, completion: nil)
    }
}


extension MenuInicialViewController: GameCenterHelperDelegate {
  func didChangeAuthStatus(isAuthenticated: Bool) {
      print("changed status is auth: \(isAuthenticated)")
    startButton.isEnabled = isAuthenticated
    connectionStatusLabel.text = "Connected to Game Center"
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
      let prep: PreparingPlayres = PreparingPlayres(name: "", ready: false, catcher: 0)
      self.navigationController?.isNavigationBarHidden = true
      self.navigationController?.popViewController(animated: true)
      self.navigationController?.pushViewController(PreparingViewController(match: match, prep: prep, definingCatcher: IsCatcher(catcher: 0, name: "")), animated: true)
      
  }
}
