//
//  SettingsViewController.swift
//  CarameloRun
//
//  Created by Pamella Alvarenga on 10/11/23.
//

import Foundation
import UIKit

class CreditsPopUpViewController: UIViewController {
    
    let exitButtonImage = UIImage(named: "ExitButton")
    let exitButton = UIButton(type: UIButton.ButtonType.custom)
    var labelTitle: UILabel = UILabel()
    let stackView = UIStackView()
    let developers = ["Caio Melloni", "Joshua Ramos" , "Luis Siqueira", "Marcelo Duarte", "Pamella Alvarenga"]
    let stackViewLabel = UILabel()
    
    private var canvas: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = UIColor(red: 248.0/255.0, green: 228.0/255.0, blue: 172.0/255.0, alpha: 1.0)
        contentView.layer.borderWidth = 3
        contentView.layer.borderColor = UIColor.black.cgColor

        return contentView
    }()
 
    public override func viewDidLoad() {
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        view.addSubview(canvas)
        configureCanvas()

        view.addSubview(exitButton)
        configureExitButton()
        
        super.viewDidLoad()
        
    }
    
    func configureExitButton() {
        
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.setImage(exitButtonImage, for: .normal)
        exitButton.addTarget(self, action: #selector(showMenuInicial), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            exitButton.widthAnchor.constraint(equalToConstant: 40),
            exitButton.heightAnchor.constraint(equalToConstant: 40),
            exitButton.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: 10),
            exitButton.topAnchor.constraint(equalTo: canvas.topAnchor, constant: -10)
            
        ])
    }
    
    @objc func showMenuInicial(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureCanvas() {
        
        canvas.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            canvas.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            canvas.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            canvas.widthAnchor.constraint(equalToConstant: 288),
            canvas.heightAnchor.constraint(equalToConstant: 264)
            
        ])
        
        labelTitle.text = "Desenvolvedores"
        labelTitle.font = UIFont(name: "Crang", size: 22)
        labelTitle.textColor = UIColor(red: 215.0/255.0, green: 94.0/255.0, blue: 64.0/255.0, alpha: 1.0)
        
        canvas.addSubview(labelTitle)
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            labelTitle.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 24),
            labelTitle.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 16)
            
        ])
        
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.axis = .vertical
        
        canvas.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 8),
            stackView.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: canvas.centerYAnchor)
        ])
                
        stackView.addArrangedSubview(stackViewLabel)
        
        for dev in developers {
            let labelStackView = UILabel()
            labelStackView.text = "\(dev)"
            stackView.addArrangedSubview(labelStackView)
            labelStackView.textColor = UIColor(red: 64.0/255.0, green: 73.0/255.0, blue: 73.0/255.0, alpha: 1.0)
            labelStackView.font = UIFont.boldSystemFont(ofSize: 18)
            labelStackView.textAlignment = .left
        }
        
    }
    
  
}
