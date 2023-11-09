
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
    let buttonImage = UIImage(named: "startButton") as UIImage?
    let button = UIButton(type: UIButton.ButtonType.custom) as UIButton
    let gameCenterHelper = GameCenterHelper()
    let connectionStatusLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.isEnabled = false
        
        
        configureButton()
        configureStackView()
        setStackViewConstraints()
        gameCenterHelper.delegate = self
        gameCenterHelper.authenticatePlayer()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundMenu.png")!)

    }
}

extension MenuInicialViewController {
    
    
    
    func configureButton() {
    
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(initGame), for: .touchUpInside)
      
    }
    
    func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .center
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(connectionStatusLabel)
    

    }
    
    func setStackViewConstraints() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)

//            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -75),
//            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32)
        ])
    }
    
    func configureConnectionStatusLabel() {
        connectionStatusLabel.text = "You are not connected to Game Center"
       
//        if let interFont = UIFont(name: "Inter", size: 16){
//            print("inter")
//            connectionStatusLabel.font = interFont
//        } else {print("deu ruim")}
        connectionStatusLabel.textAlignment = .center
        connectionStatusLabel.numberOfLines = 1
    }
    
    @objc func initGame() {
        gameCenterHelper.presentMatchmaker()
    }
}


extension MenuInicialViewController: GameCenterHelperDelegate {
  func didChangeAuthStatus(isAuthenticated: Bool) {
      print("changed status is auth: \(isAuthenticated)")
    button.isEnabled = isAuthenticated
    connectionStatusLabel.text = "Connected to Game Center"

    
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
      self.navigationController?.pushViewController(PreparingViewController(match: match, prep: prep), animated: true)
      //self.navigationController?.pushViewController(GameViewController(match: match), animated: true)
  }
}
