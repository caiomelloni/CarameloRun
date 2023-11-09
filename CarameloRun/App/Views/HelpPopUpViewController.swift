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
        return control
    }()
    
    
    public override func viewDidLoad() {
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.addSubview(canvas)
        setCanvasConstraints()
        
        view.addSubview(segmentedControl)
        setupSegmentedControl()
        
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
        canvas.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8),
        canvas.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.5)
        ])
    }
    
    
}
