
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButton(startButton, startButtonImage, action: #selector(initGame))
        configureButton(helpButton, helpButtonImage, action: #selector(showHelpPopUp))
        
        startButton.isEnabled = false
        configureStackView()
        setConstraints()
        gameCenterHelper.delegate = self
        gameCenterHelper.authenticatePlayer()
        
        view.addSubview(helpButton)

        self.view.backgroundColor = ColorsConstants.menuBackgroundImage

    }
}

extension MenuInicialViewController {
    
    
    
    public func configureButton(_ chosenButton: UIButton, _ buttonImage: UIImage?, action: Selector) {
        chosenButton.translatesAutoresizingMaskIntoConstraints = false
        chosenButton.setImage(buttonImage, for: .normal)
        chosenButton.addTarget(self, action: action, for: .touchUpInside)
        view.addSubview(chosenButton)
    }
    
    func configureStackView() {
        view.addSubview(stackViewMenuInicial)
        stackViewMenuInicial.axis = .vertical
        stackViewMenuInicial.spacing = 24
        stackViewMenuInicial.alignment = .center
        stackViewMenuInicial.addArrangedSubview(logoImageView)
        stackViewMenuInicial.addArrangedSubview(startButton)
        
    }
    
    func setConstraints() {
        
        stackViewMenuInicial.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewMenuInicial.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewMenuInicial.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        helpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            helpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            helpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -56)
           
        ])
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
