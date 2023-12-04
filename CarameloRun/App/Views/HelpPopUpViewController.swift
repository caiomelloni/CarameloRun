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
    
    let exitButtonImage = Images.exitButtonImage
    let exitButton = UIButton(type: UIButton.ButtonType.custom)
    
    var canvas: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = ColorsConstants.backgroundColor
        scrollView.layer.borderWidth = 3
        scrollView.layer.borderColor = UIColor.black.cgColor
        
        return scrollView
    }()
    
    var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let items = [ "Regras" , "Controles" , "Como Conectar", "créditos"]
    
    let developers:[String] = ["Pamella de Alvarenga Souza", "Joshua Matheus", "Marcelo Pastana Duarte", "Luis Siqueira", "Caio Melloni"]
    
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        
        let font = Fonts.subTitleFont
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: font as Any,
            NSAttributedString.Key.foregroundColor: ColorsConstants.tittlesColor
        ]
        
        control.setTitleTextAttributes(attributes, for: .normal)
        control.selectedSegmentTintColor = ColorsConstants.selectedSegment
        control.backgroundColor = ColorsConstants.unselectedSegment
        control.addTarget(self, action: #selector(handleSegmentedControlValueCHanged), for: .valueChanged)
        
        return control
    }()
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configureCanvas0()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        view.addSubview(canvas)
        view.addSubview(segmentedControl)
        view.addSubview(exitButton)
        createExitButton()
        configureConstraints()
        configureCanvas0()
        
        super.viewDidLoad()
        
    }
    
    
    func createExitButton() {
        exitButton.setImage(exitButtonImage, for: .normal)
        exitButton.addTarget(self, action: #selector(showMenuInicial), for: .touchUpInside)
    }
    
    
    @objc func showMenuInicial(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSegmentedControlValueCHanged(_ sender: UISegmentedControl) {
        
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
        switch sender.selectedSegmentIndex {
        case 0:
            
            configureCanvas0()
            
        case 1:
            configureCanvas1()
            
        case 2:
            configureCanvas2()
            
        case 3:
            configureCanvas3()
            
        default:
            configureCanvas0()
        }
        
        view.addSubview(canvas)
        view.addSubview(segmentedControl)
        view.addSubview(exitButton)
        configureConstraints()
    }
    
}

extension HelpPopUpViewController { // Just defining constraints
    
    func configureConstraints() {
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exitButton.widthAnchor.constraint(equalToConstant: 40),
            exitButton.heightAnchor.constraint(equalToConstant: 40),
            exitButton.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: 10),
            exitButton.topAnchor.constraint(equalTo: canvas.topAnchor, constant: -10)
            
        ])
        
        canvas.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            canvas.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            canvas.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            canvas.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            canvas.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            canvas.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            canvas.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24)
            
        ])
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            segmentedControl.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 24),
            segmentedControl.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -24),
            segmentedControl.heightAnchor.constraint(equalToConstant: 32)
            
        ])
        
    }
    
}







