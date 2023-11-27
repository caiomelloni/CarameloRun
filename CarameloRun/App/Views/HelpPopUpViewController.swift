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

class IconLabelView: UIView {
    let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    let label: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setupSubviews()
        }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupSubviews()
        }
    
    private func setupSubviews() {
            addSubview(imageView)
            addSubview(label)
            
            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
                label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
                label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
                
            ])
        
            label.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)

        }
        
        func configure(with image: UIImage?, text: String) {
            imageView.image = image
            label.text = text
          
        }
}

class HelpPopUpViewController: UIViewController {
   
    let exitButtonImage = UIImage(named: "ExitButton") as UIImage?
    let exitButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
    var labelTitle1: UILabel = UILabel()
    let labelDescription1: UILabel = UILabel()
    let labelTitle2: UILabel = UILabel()
    let labelDescription2: UILabel = UILabel()
    let mainStackView = UIStackView()
    let labelStackView = UIStackView()
    let ButtonLeftImageView = UIImageView(image: UIImage(named: "ButtonLeftUp"))
    let ButtonRightImageView = UIImageView(image: UIImage(named: "ButtonRightUp"))
    let ButtonJumpImageView = UIImageView(image: UIImage(named: "JumpButtonUp"))
    var alreadyCalled = false
    
//    private var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.backgroundColor = UIColor.blue
//        
//        return scrollView
//    }()
    
    private var canvas: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.backgroundColor = UIColor(red: 248.0/255.0, green: 228.0/255.0, blue: 172.0/255.0, alpha: 1.0)
    scrollView.layer.borderWidth = 3
    scrollView.layer.borderColor = UIColor.black.cgColor
 
    return scrollView
    }()
    
    private var contentView: UIView = {
        let view = UIView()
       // view.backgroundColor = UIColor.green
       
        return view
    }()
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
            //self.canvas  // Initialize in the init method
            configureCanvas0()
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
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
          
            print("case 0")
            configureCanvas0()
            
        case 1:
            configureCanvas1()

        case 2:
            print("case 2")
            //configureCanvas2()

        default:
            print("case default")
            //configureCanvas0()
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
        
        labelTitle1.text = "Caramelo"
        labelTitle1.font = UIFont(name: "Crang", size: 30)
        labelTitle1.textColor = UIColor(red: 215.0/255.0, green: 94.0/255.0, blue: 64.0/255.0, alpha: 1.0)
        
        contentView.addSubview(labelTitle1)

        labelTitle1.translatesAutoresizingMaskIntoConstraints = false
        
            NSLayoutConstraint.activate([

                labelTitle1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 68),
                labelTitle1.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24)
       
            ])
        
        labelDescription1.text = "O Caramelo é um cãozinho fofo e malandro que vive feliz pelas ruas brasileiras. Mas, infelizmente, o Zé Cadelo, funcionário da carrocinha, está prestes a Capturar o Caramelo! O seu objetivo nessa missão é ajudar nosso querido cãozinho a fazer amizade com os moradores da vizinhança e ser adotado antes que o Zé cadelo o alcance!"
        
        labelDescription1.font = UIFont(name: "Inter", size: 13)
        labelDescription1.textColor = UIColor(red: 32.0/255.0, green: 46.0/255.0, blue: 55.0/255.0, alpha: 1.0)
        labelDescription1.numberOfLines = 0
        
        contentView.addSubview(labelDescription1)

        labelDescription1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            labelDescription1.topAnchor.constraint(equalTo: labelTitle1.bottomAnchor, constant: 12),
            labelDescription1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            labelDescription1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
            
        ])
        
        
        labelTitle2.text = "Zé Cadelo"
        labelTitle2.font = UIFont(name: "Crang", size: 30)
        labelTitle2.textColor = UIColor(red: 215.0/255.0, green: 94.0/255.0, blue: 64.0/255.0, alpha: 1.0)
        
        contentView.addSubview(labelTitle2)
        
        labelTitle2.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            labelTitle2.topAnchor.constraint(equalTo: labelDescription1.bottomAnchor, constant: 24),
            labelTitle2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24)
            
        ])
        
        labelDescription2.text = "O Zé cadelo precisa garantir seu emprego e, para isso, precisa tirar cães abandonas da rua e levá-los para o abrigo. Infelizmente, esses cãezinhos são malandros e conhecem os catons da cidade melhor que o Zé. Tente capturá-los, usando sua rede, para vencer a partida."
        labelDescription2.font = UIFont(name: "Inter", size: 13)
        labelDescription2.textColor = UIColor(red: 32.0/255.0, green: 46.0/255.0, blue: 55.0/255.0, alpha: 1.0)
        labelDescription2.numberOfLines = 0
        
        contentView.addSubview(labelDescription2)

        labelDescription2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            labelDescription2.topAnchor.constraint(equalTo: labelTitle2.bottomAnchor, constant: 12),
            labelDescription2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            labelDescription2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            labelDescription2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

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

        labelTitle1.text = "Controles"
        labelTitle1.font = UIFont(name: "Crang", size: 30)
        labelTitle1.textColor = UIColor(red: 215.0/255.0, green: 94.0/255.0, blue: 64.0/255.0, alpha: 1.0)
        
        contentView.addSubview(labelTitle1)
        
        labelTitle1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            labelTitle1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 68),
            labelTitle1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
            
        ])
        
        
        contentView.addSubview(mainStackView)
        
        mainStackView.alignment = .center
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 16
        mainStackView.axis = .vertical
        
        ButtonLeftImageView.contentMode = .scaleAspectFit
        ButtonRightImageView.contentMode = .scaleAspectFit
        ButtonJumpImageView.contentMode = .scaleAspectFit
        
        mainStackView.addArrangedSubview(jumpView)
        mainStackView.addArrangedSubview(leftView)
        mainStackView.addArrangedSubview(rightView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: labelTitle1.bottomAnchor, constant: 26),
           // mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            mainStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
            
        ])


    }
    
    func configureCanvas2() {
            
        labelTitle1.text = "Partira Rápida"
        labelTitle1.font = UIFont(name: "Crang", size: 30)
        labelTitle1.textColor = UIColor(red: 215.0/255.0, green: 94.0/255.0, blue: 64.0/255.0, alpha: 1.0)
        
        contentView.addSubview(labelTitle1)

        labelTitle1.translatesAutoresizingMaskIntoConstraints = false
        
            NSLayoutConstraint.activate([

                labelTitle1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 68),
                labelTitle1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
       
            ])
        
        labelDescription1.text = "Nesse estilo de conexão, você pode jogar com qualquer outro jogador conectado ao GameCenter no mesmo momento que você. Basta clicar em \"partida rápida” após iniciar o jogo e aguardar que a conexão será feita automaticamente, direcionando vocês para a partida em seguida."
        
        labelDescription1.font = UIFont(name: "Inter", size: 13)
        labelDescription1.textColor = UIColor(red: 32.0/255.0, green: 46.0/255.0, blue: 55.0/255.0, alpha: 1.0)
        labelDescription1.numberOfLines = 0
        
        contentView.addSubview(labelDescription1)

        labelDescription1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            labelDescription1.topAnchor.constraint(equalTo: labelTitle1.bottomAnchor, constant: 12),
            labelDescription1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelDescription1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
           
        ])
        
        labelTitle2.text = "Convidar seu amigo"
        labelTitle2.font = UIFont(name: "Crang", size: 30)
        labelTitle2.textColor = UIColor(red: 215.0/255.0, green: 94.0/255.0, blue: 64.0/255.0, alpha: 1.0)
        
        contentView.addSubview(labelTitle2)
        
        labelTitle2.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            labelTitle2.topAnchor.constraint(equalTo: labelDescription1.bottomAnchor, constant: 24),
            labelTitle2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
            
        ])
        
        labelDescription2.text = "Para esse tipo de conexão, é necessário saber o nome de usuário do GameCenter de seu amigo. Em seguida, deve-se clicar em \"convidar jogador” após iniciar o jogo e aguardar o GameCenter enviar o convite para ele. O seu amigo deve aceitá-lo e aguardar até que a conexão seja feita."
        labelDescription2.font = UIFont(name: "Inter", size: 13)
        labelDescription2.textColor = UIColor(red: 32.0/255.0, green: 46.0/255.0, blue: 55.0/255.0, alpha: 1.0)
        labelDescription2.numberOfLines = 0
        
        contentView.addSubview(labelDescription2)

        labelDescription2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            labelDescription2.topAnchor.constraint(equalTo: labelTitle2.bottomAnchor, constant: 12),
            labelDescription2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelDescription2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
           
        ])
     
        }
   
    
    
}

