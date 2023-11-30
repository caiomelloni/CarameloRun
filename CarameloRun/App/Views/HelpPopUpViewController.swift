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
    
    let exitButtonImage = UIImage(named: "ExitButton") as UIImage?
    let exitButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
    
    let labelTitle1RegrasTab: UILabel = UILabel()
    let labelDescription1RegrasTab: UILabel = UILabel()
    let labelTitle2RegrasTab: UILabel = UILabel()
    let labelDescription2RegrasTab: UILabel = UILabel()
    
    let labelTitle1ComoConectarTab: UILabel = UILabel()
    let labelDescription1ComoConectarTab: UILabel = UILabel()
    let labelTitle2ComoConectarTab: UILabel = UILabel()
    let labelDescription2ComoConectarTab: UILabel = UILabel()
    
    let stackViewControlesTab = UIStackView()
    let stackViewCreditosTab = UIStackView()
    
    let ButtonLeftControlImageView = UIImageView(image: UIImage(named: "ButtonLeftUp"))
    let ButtonRightControlImageView = UIImageView(image: UIImage(named: "ButtonRightUp"))
    let ButtonJumpControlImageView = UIImageView(image: UIImage(named: "JumpButtonUp"))
    
    var ControlesTabAlreadyAcessed = false
    var CreditosTabAlreadyAcessed = false

    
 
    
    private var canvas: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = ColorsConstants.backgroundColor
        scrollView.layer.borderWidth = 3
        scrollView.layer.borderColor = UIColor.black.cgColor
        
        return scrollView
    }()
    
    private var contentView: UIView = {
        let view = UIView()
  
        
        return view
    }()
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configureCanvas0()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let items = [ "Regras" , "Controles" , "Como Conectar", "créditos"]
    
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        
        let font = UIFont(name: "Crang", size: 16)
        
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
    
    
    public override func viewDidLoad() {
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        view.addSubview(canvas)
        setcanvasConstraints()
        
        view.addSubview(segmentedControl)
        setupSegmentedControl()
        
        view.addSubview(exitButton)
        configureExitButton()
        
        configureCanvas0()
        
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
    
    func setcanvasConstraints() {
        
        canvas.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            canvas.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            canvas.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            canvas.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            canvas.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
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
        setcanvasConstraints()
        setupSegmentedControl()
        configureExitButton()
    }
    
    func configureCanvas0() {
        
        self.canvas.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let hConst =  contentView.heightAnchor.constraint(equalTo: canvas.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        
        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(equalTo: self.canvas.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.canvas.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.canvas.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.canvas.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: self.canvas.widthAnchor)
            
        ])
        
        labelTitle1RegrasTab.text = HelpPopUpViewStrings.Title1RegrasTabText.localized()
        labelTitle1RegrasTab.font = UIFont(name: "Crang", size: 30)
        labelTitle1RegrasTab.textColor = ColorsConstants.tittlesColor
        
        contentView.addSubview(labelTitle1RegrasTab)
        
        labelTitle1RegrasTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            labelTitle1RegrasTab.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 68),
            labelTitle1RegrasTab.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24)
            
        ])
        
        labelDescription1RegrasTab.text = HelpPopUpViewStrings.Description1RegrasTabText.localized()
        
        labelDescription1RegrasTab.font = UIFont(name: "Inter", size: 13)
        labelDescription1RegrasTab.textColor = ColorsConstants.textColor
        labelDescription1RegrasTab.numberOfLines = 0
        
        contentView.addSubview(labelDescription1RegrasTab)
        
        labelDescription1RegrasTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            labelDescription1RegrasTab.topAnchor.constraint(equalTo: labelTitle1RegrasTab.bottomAnchor, constant: 12),
            labelDescription1RegrasTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            labelDescription1RegrasTab.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
            
        ])
        
        
        labelTitle2RegrasTab.text = HelpPopUpViewStrings.Title2RegrasTabText.localized()
        
        //"Zé Cadelo"
        labelTitle2RegrasTab.font = UIFont(name: "Crang", size: 30)
        labelTitle2RegrasTab.textColor = ColorsConstants.tittlesColor
        
        contentView.addSubview(labelTitle2RegrasTab)
        
        labelTitle2RegrasTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            labelTitle2RegrasTab.topAnchor.constraint(equalTo: labelDescription1RegrasTab.bottomAnchor, constant: 24),
            labelTitle2RegrasTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24)
            
        ])
        
        labelDescription2RegrasTab.text = HelpPopUpViewStrings.Description2RegrasTabText.localized()
        labelDescription2RegrasTab.font = UIFont(name: "Inter", size: 13)
        labelDescription2RegrasTab.textColor = ColorsConstants.textColor
        labelDescription2RegrasTab.numberOfLines = 0
        
        contentView.addSubview(labelDescription2RegrasTab)
        
        labelDescription2RegrasTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            labelDescription2RegrasTab.topAnchor.constraint(equalTo: labelTitle2RegrasTab.bottomAnchor, constant: 12),
            labelDescription2RegrasTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            labelDescription2RegrasTab.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            labelDescription2RegrasTab.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
        
    }
    
    func configureCanvas1() {
        
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        self.canvas.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let jumpView = IconLabelView()
        jumpView.configure(with: UIImage(named: "JumpButtonUp"), text: "Pular")
        
        let leftView = IconLabelView()
        leftView.configure(with: UIImage(named: "ButtonLeftUp"), text: "Andar para a esquerda")
        
        let rightView = IconLabelView()
        rightView.configure(with: UIImage(named: "ButtonRightUp"), text: "Andar para a direita")
        
        self.canvas.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let hConst =  contentView.heightAnchor.constraint(equalTo: canvas.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        
        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(equalTo: self.canvas.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.canvas.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.canvas.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.canvas.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: self.canvas.widthAnchor)
            
        ])
        
        labelTitle1RegrasTab.text = "Controles"
        labelTitle1RegrasTab.font = UIFont(name: "Crang", size: 30)
        labelTitle1RegrasTab.textColor = ColorsConstants.tittlesColor
        
        contentView.addSubview(labelTitle1RegrasTab)
        
        labelTitle1RegrasTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            labelTitle1RegrasTab.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 68),
            labelTitle1RegrasTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
            
        ])
        
        
        contentView.addSubview(stackViewControlesTab)
        
        stackViewControlesTab.alignment = .center
        stackViewControlesTab.distribution = .equalSpacing
        stackViewControlesTab.spacing = 0
        stackViewControlesTab.axis = .vertical
        
        ButtonLeftControlImageView.contentMode = .scaleAspectFit
        ButtonRightControlImageView.contentMode = .scaleAspectFit
        ButtonJumpControlImageView.contentMode = .scaleAspectFit
        
        if !ControlesTabAlreadyAcessed {
            stackViewControlesTab.addArrangedSubview(jumpView)
            stackViewControlesTab.addArrangedSubview(leftView)
            stackViewControlesTab.addArrangedSubview(rightView)
        }
        
        stackViewControlesTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackViewControlesTab.topAnchor.constraint(equalTo: labelTitle1RegrasTab.bottomAnchor, constant: 26),
            stackViewControlesTab.widthAnchor.constraint(equalToConstant: 150),
            stackViewControlesTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            stackViewControlesTab.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
        
        ControlesTabAlreadyAcessed = true
    }
    
    func configureCanvas2() {
        
        self.canvas.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let hConst =  contentView.heightAnchor.constraint(equalTo: canvas.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        
        labelTitle1ComoConectarTab.text = "Partira Rápida"
        labelTitle1ComoConectarTab.font = UIFont(name: "Crang", size: 30)
        labelTitle1ComoConectarTab.textColor = ColorsConstants.tittlesColor
        
        contentView.addSubview(labelTitle1ComoConectarTab)
        
        labelTitle1ComoConectarTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            labelTitle1ComoConectarTab.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 68),
            labelTitle1ComoConectarTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
            
        ])
        
        labelDescription1ComoConectarTab.text = "Nesse estilo de conexão, você pode jogar com qualquer outro jogador conectado ao GameCenter no mesmo momento que você. Basta clicar em \"partida rápida” após iniciar o jogo e aguardar que a conexão será feita automaticamente, direcionando vocês para a partida em seguida."
        
        labelDescription1ComoConectarTab.font = UIFont(name: "Inter", size: 13)
        labelDescription1ComoConectarTab.textColor = ColorsConstants.textColor
        labelDescription1ComoConectarTab.numberOfLines = 0
        
        contentView.addSubview(labelDescription1ComoConectarTab)
        
        labelDescription1ComoConectarTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            labelDescription1ComoConectarTab.topAnchor.constraint(equalTo: labelTitle1ComoConectarTab.bottomAnchor, constant: 12),
            labelDescription1ComoConectarTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelDescription1ComoConectarTab.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
            
        ])
        
        labelTitle2ComoConectarTab.text = "Convidar seu amigo"
        labelTitle2ComoConectarTab.font = UIFont(name: "Crang", size: 30)
        labelTitle2ComoConectarTab.textColor = ColorsConstants.tittlesColor
        
        contentView.addSubview(labelTitle2ComoConectarTab)
        
        labelTitle2ComoConectarTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            labelTitle2ComoConectarTab.topAnchor.constraint(equalTo: labelDescription1ComoConectarTab.bottomAnchor, constant: 24),
            labelTitle2ComoConectarTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
            
        ])
        
        labelDescription2ComoConectarTab.text = "Para esse tipo de conexão, é necessário saber o nome de usuário do GameCenter de seu amigo. Em seguida, deve-se clicar em \"convidar jogador” após iniciar o jogo e aguardar o GameCenter enviar o convite para ele. O seu amigo deve aceitá-lo e aguardar até que a conexão seja feita."
        labelDescription2ComoConectarTab.font = UIFont(name: "Inter", size: 13)
        labelDescription2ComoConectarTab.textColor = ColorsConstants.textColor
        labelDescription2ComoConectarTab.numberOfLines = 0
        
        contentView.addSubview(labelDescription2ComoConectarTab)
        
        labelDescription2ComoConectarTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            labelDescription2ComoConectarTab.topAnchor.constraint(equalTo: labelTitle2ComoConectarTab.bottomAnchor, constant: 12),
            labelDescription2ComoConectarTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelDescription2ComoConectarTab.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            labelDescription2ComoConectarTab.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
        
    }
    
    func configureCanvas3() {
        
        let developers:[String] = ["Pamella de Alvarenga Souza", "Joshua Matheus", "Marcelo Pastana Duarte", "Luis Siqueira", "Caio Melloni"]
        
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        self.canvas.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let hConst =  contentView.heightAnchor.constraint(equalTo: canvas.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        
        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(equalTo: self.canvas.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.canvas.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.canvas.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.canvas.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: self.canvas.widthAnchor)
        ])
        
        labelTitle1RegrasTab.text = "Desenvolvedores"
        labelTitle1RegrasTab.font = UIFont(name: "Crang", size: 30)
        labelTitle1RegrasTab.textColor = ColorsConstants.tittlesColor
        
        contentView.addSubview(labelTitle1RegrasTab)
        
        labelTitle1RegrasTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            labelTitle1RegrasTab.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 68),
            labelTitle1RegrasTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
        ])
    
        contentView.addSubview(stackViewCreditosTab)
        
        stackViewCreditosTab.alignment = .leading
        stackViewCreditosTab.distribution = .equalSpacing
        stackViewCreditosTab.spacing = 12
        stackViewCreditosTab.axis = .vertical
        
        ButtonLeftControlImageView.contentMode = .scaleAspectFit
        ButtonRightControlImageView.contentMode = .scaleAspectFit
        ButtonJumpControlImageView.contentMode = .scaleAspectFit
        
        if !CreditosTabAlreadyAcessed {
            for developerName in developers {
                let label = UILabel()
                label.font = UIFont(name: "Inter", size: 13)
                label.textColor = ColorsConstants.textColor
                label.numberOfLines = 1
                label.text = developerName
                stackViewCreditosTab.addArrangedSubview(label)
            }
        }
        
        stackViewCreditosTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            stackViewCreditosTab.topAnchor.constraint(equalTo: labelTitle1RegrasTab.bottomAnchor, constant: 26),
            stackViewCreditosTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
            
        ])
        
        CreditosTabAlreadyAcessed = true
    }
}


