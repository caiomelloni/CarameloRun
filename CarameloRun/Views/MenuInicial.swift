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
    let button = UIButton(type: .system)
    let gameCenterHelper = GameCenterHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.isEnabled = false
        style()
        layout()
        gameCenterHelper.delegate = self
        gameCenterHelper.authenticatePlayer()
    }
}

extension MenuInicialViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Iniciar jogo", for: .normal)
        button.addTarget(self, action: #selector(initGame), for: .touchUpInside)
    }
    
    func layout() {
        stackView.addArrangedSubview(button)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc func initGame() {
        gameCenterHelper.presentMatchmaker()
    }
}


extension MenuInicialViewController: GameCenterHelperDelegate {
  func didChangeAuthStatus(isAuthenticated: Bool) {
      print("changed status is auth: \(isAuthenticated)")
    button.isEnabled = isAuthenticated
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
    performSegue(withIdentifier: "showGame", sender: match)
  }
}
