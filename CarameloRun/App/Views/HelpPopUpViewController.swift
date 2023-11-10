//
//  HelpViewController.swift
//  CarameloRun
//
//  Created by Pamella Alvarenga on 09/11/23.
//

import Foundation

import Foundation
import UIKit
import GameKit
//import TinyConstraints

class HelpPopUpViewController: UIViewController {
   
    let exitButtonImage = UIImage(named: "ExitButton") as UIImage?
    let exitButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
    
    private lazy var canvas: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red: 248.0/255.0, green: 228.0/255.0, blue: 172.0/255.0, alpha: 1.0)
    view.layer.borderWidth = 3
    view.layer.borderColor = UIColor.black.cgColor
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
    }()
    
    
    let items = [ "Regras" , "Controles" , "Como Conectar"]
        
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        
        let font = UIFont(name: "Crang", size: 16)
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: font as Any,
            NSAttributedString.Key.foregroundColor: UIColor(red: 215.0/255.0, green: 94.0/255.0, blue: 64.0/255.0, alpha: 1.0)
                ]
        
        control.setTitleTextAttributes(attributes, for: .normal)
        control.selectedSegmentTintColor = UIColor(red: 255.0/255.0, green: 240.0/255.0, blue: 199.0/255.0, alpha: 1.0)
        control.backgroundColor = UIColor(red: 232.0/255.0, green: 214.0/255.0, blue: 166.0/255.0, alpha: 1.0)
        
        return control
    }()
    
    
    public override func viewDidLoad() {
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        view.addSubview(canvas)
        setCanvasConstraints()
        
        view.addSubview(segmentedControl)
        setupSegmentedControl()
        
        view.addSubview(exitButton)
        configureExitButton()

        super.viewDidLoad()
        
    }
    
    func setupSegmentedControl() {
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            segmentedControl.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 24),
            segmentedControl.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -24),
            segmentedControl.heightAnchor.constraint(equalToConstant: 32)
      
        ])
        
       
    }
    
    func setCanvasConstraints() {
        NSLayoutConstraint.activate([
        canvas.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        canvas.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        canvas.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        canvas.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 24),
        canvas.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
        canvas.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24)
        
        ])
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
    
    
}
