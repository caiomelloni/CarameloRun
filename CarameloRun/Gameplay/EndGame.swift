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
    var name: String
    var victory: Bool
    
    init(_ score: Int, _ name: String, _ victory: Bool) {
        self.score = score
        self.name = name
        self.victory = victory
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure a view com uma cor de fundo verde se venceu, vermelha se perdeu
        if victory{
            view.backgroundColor = .green
        } else {
            view.backgroundColor = .red
        }
        
    
        // Crie uma label para o texto "Fim de Jogo"
        let label = UILabel()
        if victory {
            label.text = "Vitória"
        } else {
            label.text = "Derrota"
        }
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 36)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        // Adicione a label à vista
        view.addSubview(label)
        
        // Defina restrições para centralizar a label na tela
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        // add score for all players
        if GKLocalPlayer.local.isAuthenticated {
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
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            label.text = "Fim de jogo"
            label.textColor = .white
            view.backgroundColor = .black
            addButtons()
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
    
    func addButtons() {
        let button = UIButton()
        button.setTitle("LeaderBoard", for: .normal)
        button.frame = CGRect(x: 2*UIScreen.main.bounds.size.width/3, y: 3*UIScreen.main.bounds.size.height/4, width: 200, height: 40)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.backgroundColor = .orange
        
        view.addSubview(button)
            
        let button2 = UIButton()
        button2.setTitle("Menu Principal", for: .normal)
        button2.frame = CGRect(x: UIScreen.main.bounds.size.width/6, y: 3*UIScreen.main.bounds.size.height/4, width: 200, height: 40)
        button2.addTarget(self, action: #selector(buttonTappedToMenu), for: .touchUpInside)
        button2.backgroundColor = .orange

        view.addSubview(button2)
    }
    
    
    @objc func buttonTappedToMenu() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

