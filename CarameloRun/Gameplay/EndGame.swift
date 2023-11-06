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
    private let leaderboardID = "Pontos"
    private var leaderboard: GKLeaderboard?
    
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
        button.frame = CGRect(x: 500, y: 300, width: 200, height: 40)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.backgroundColor = .orange

        view.addSubview(button)
        
        //teste de adição de score para os players
        if GKLocalPlayer.local.isAuthenticated {
            
            GKLeaderboard.loadLeaderboards(IDs: ["Pontos"] ){ (fetchedLBs, error) in
                if let lb = fetchedLBs?.first {
                    lb.submitScore(10, context: 0, player: GKLocalPlayer.local, completionHandler: { error in
                    print("Error sending score")
                    })
                }
            }
            
            leaderboard?.submitScore(10, context: 0, player: GKLocalPlayer.local, completionHandler: {_ in
                print("Error")
            })
            
        }
        
        // apresenta a LeaderBoard do gameCenter
        showLeaderBoard()
        
    }
    
    func leaderboard() async{
        Task{
            try await GKLeaderboard.submitScore(
                20,
                context: 0,
                player: GKLocalPlayer.local,
                leaderboardIDs: ["Pontos"]
            )
        }
    }
    
    func updateScore(value: Int) {
        let score = GKLeaderboardScore()
        score.value = value
        score.player = GKLocalPlayer.local
        score.leaderboardID = "Pontos"
        
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

