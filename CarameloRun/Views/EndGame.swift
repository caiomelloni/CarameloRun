//
//  EndGame.swift
//  CarameloRun
//
//  Created by Luis Silva on 30/10/23.
//

import Foundation
import UIKit


class EndGame: UIViewController {
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
        }
}



