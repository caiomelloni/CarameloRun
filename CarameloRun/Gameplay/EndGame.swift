//
//  EndGame.swift
//  CarameloRun
//
//  Created by Luis Silva on 30/10/23.
//

import Foundation
import UIKit
import GameKit


class EndGame: UIViewController, GKGameCenterControllerDelegate {
    
    var score: Int
    
    init(_ score: Int) {
        self.score = score
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure a view com uma cor de fundo preta
        view.backgroundColor = .black
    
        // Crie uma label para o texto "Fim de Jogo"
        let label = UILabel()
        label.text = "Fim de Jogo"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 36)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        // Adicione a label à vista
        view.addSubview(label)
        
        // Defina restrições para centralizar a label na tela
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let button = UIButton()
        button.setTitle("Mostrar LeaderBoard", for: .normal)
        button.frame = CGRect(x: UIScreen.main.bounds.size.width/2, y: -UIScreen.main.bounds.size.height/3, width: 200, height: 40)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.backgroundColor = .orange

        view.addSubview(button)
        
        // add score for all players
        if GKLocalPlayer.local.isAuthenticated {
            print(self.score)
            GKLeaderboard.loadLeaderboards(IDs: ["melhor.pontuacao"] ){ (fetchedLBs, error) in
                if let lb = fetchedLBs?.first {
                    lb.submitScore(self.score, context: 0, player: GKLocalPlayer.local, completionHandler: { error in
                        if error != nil {
                            print("Error sending score")
                        }
                        
                    })
                }
            }
            
            GKLeaderboard.loadLeaderboards(IDs: ["pontuacao.mais.recente"] ){ (fetchedLBs, error) in
                if let lb = fetchedLBs?.first {
                    lb.submitScore(self.score, context: 1, player: GKLocalPlayer.local, completionHandler: { error in
                        if error != nil {
                            print("Error sending score")
                        }
                    })
                }
            }
        }
        
        // shows the LeaderBoard of gameCenter
        Task {
            try? await Task.sleep(nanoseconds: 4_000_000_000)
            showLeaderBoard()
        }
        
    }
    
    @objc func buttonTapped() {
        showLeaderBoard()
    }
    
    func showLeaderBoard() {
        let gameCenterVC = GKGameCenterViewController(state: .leaderboards)
        gameCenterVC.gameCenterDelegate = self
        present(gameCenterVC, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
}

