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

class HelpPopUpViewController: UIViewController {
   
    private lazy var canvas: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red: 248.0/255.0, green: 228.0/255.0, blue: 172.0/255.0, alpha: 1.0)
    return view
    }()
    
    
    public override func viewDidLoad() {
        
        configureCanvas()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.addSubview(canvas)
                
        super.viewDidLoad()
        
    }
    
    func configureCanvas() {
        
        canvas.translatesAutoresizingMaskIntoConstraints = false
        
        canvas.layer.borderWidth = 3
        canvas.layer.borderColor = UIColor.black.cgColor
       
        NSLayoutConstraint.activate([
        canvas.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        canvas.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        canvas.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8),
        canvas.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.5)
        ])
        
    }
    
    
}
