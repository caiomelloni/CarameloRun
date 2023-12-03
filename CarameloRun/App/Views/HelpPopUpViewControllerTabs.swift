//
//  HelpPopUpViewControllerTabs.swift
//  CarameloRun
//
//  Created by Pamella Alvarenga on 03/12/23.
//

import Foundation
import UIKit

extension HelpPopUpViewController {
    
    func configureCanvas0() {
        
        let labelTitle1RegrasTab: UILabel = UILabel()
        let labelDescription1RegrasTab: UILabel = UILabel()
        let labelTitle2RegrasTab: UILabel = UILabel()
        let labelDescription2RegrasTab: UILabel = UILabel()
        
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
        
        labelTitle1RegrasTab.text = HelpPopUpViewControllerStrings.Title1RegrasTabText.localized()
        labelTitle1RegrasTab.font = Fonts.titleFont
        labelTitle1RegrasTab.textColor = ColorsConstants.tittlesColor
        
        contentView.addSubview(labelTitle1RegrasTab)
        
        labelTitle1RegrasTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            labelTitle1RegrasTab.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 68),
            labelTitle1RegrasTab.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24)
            
        ])
        
        labelDescription1RegrasTab.text = HelpPopUpViewControllerStrings.Description1RegrasTabText.localized()
        labelDescription1RegrasTab.font = Fonts.bodyFont
        labelDescription1RegrasTab.textColor = ColorsConstants.textColor
        labelDescription1RegrasTab.numberOfLines = 0
        
        contentView.addSubview(labelDescription1RegrasTab)
        
        labelDescription1RegrasTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            labelDescription1RegrasTab.topAnchor.constraint(equalTo: labelTitle1RegrasTab.bottomAnchor, constant: 12),
            labelDescription1RegrasTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            labelDescription1RegrasTab.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
            
        ])
        
        
        labelTitle2RegrasTab.text = HelpPopUpViewControllerStrings.Title2RegrasTabText.localized()
        labelTitle2RegrasTab.font = Fonts.titleFont
        labelTitle2RegrasTab.textColor = ColorsConstants.tittlesColor
        
        contentView.addSubview(labelTitle2RegrasTab)
        
        labelTitle2RegrasTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            labelTitle2RegrasTab.topAnchor.constraint(equalTo: labelDescription1RegrasTab.bottomAnchor, constant: 24),
            labelTitle2RegrasTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24)
            
        ])
        
        labelDescription2RegrasTab.text = HelpPopUpViewControllerStrings.Description2RegrasTabText.localized()
        labelDescription2RegrasTab.font = Fonts.bodyFont
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
        
        let labelTitle1ControlesTab: UILabel = UILabel()
        let stackViewControlesTab = UIStackView()
        
        let jumpView = IconLabelView()
        jumpView.configure(with: Images.jumpButton, text: HelpPopUpViewControllerStrings.JumpButtonControlLegend.localized())
        
        let leftView = IconLabelView()
        leftView.configure(with: Images.leftUpButton, text: HelpPopUpViewControllerStrings.LeftButtonControlLegend.localized())
        
        let rightView = IconLabelView()
        rightView.configure(with: Images.rightUpButton, text: HelpPopUpViewControllerStrings.RightButtonControlLegend.localized())
        
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
        
        labelTitle1ControlesTab.text = HelpPopUpViewControllerStrings.Title1ControlesTabText.localized()
        labelTitle1ControlesTab.font = Fonts.titleFont
        labelTitle1ControlesTab.textColor = ColorsConstants.tittlesColor
        
        contentView.addSubview(labelTitle1ControlesTab)
        
        labelTitle1ControlesTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            labelTitle1ControlesTab.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 68),
            labelTitle1ControlesTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
            
        ])
        
        
        contentView.addSubview(stackViewControlesTab)
        
        stackViewControlesTab.alignment = .center
        stackViewControlesTab.distribution = .equalSpacing
        stackViewControlesTab.spacing = 0
        stackViewControlesTab.axis = .vertical
           
        
        if !ControlesTabAlreadyAcessed {
            stackViewControlesTab.addArrangedSubview(jumpView)
            stackViewControlesTab.addArrangedSubview(leftView)
            stackViewControlesTab.addArrangedSubview(rightView)
        }
        
        stackViewControlesTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackViewControlesTab.topAnchor.constraint(equalTo: labelTitle1ControlesTab.bottomAnchor, constant: 26),
            stackViewControlesTab.widthAnchor.constraint(equalToConstant: 150),
            stackViewControlesTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            stackViewControlesTab.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
        
        ControlesTabAlreadyAcessed = true
    }
    
    func configureCanvas2() {
        
        let labelTitle1ComoConectarTab: UILabel = UILabel()
        let labelDescription1ComoConectarTab: UILabel = UILabel()
        
        let labelTitle2ComoConectarTab: UILabel = UILabel()
        let labelDescription2ComoConectarTab: UILabel = UILabel()
        
        self.canvas.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let hConst =  contentView.heightAnchor.constraint(equalTo: canvas.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        
        labelTitle1ComoConectarTab.text = HelpPopUpViewControllerStrings.Title1ComoConectarTabText.localized()
        
        labelTitle1ComoConectarTab.font = Fonts.titleFont
        labelTitle1ComoConectarTab.textColor = ColorsConstants.tittlesColor
        
        contentView.addSubview(labelTitle1ComoConectarTab)
        
        labelTitle1ComoConectarTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            labelTitle1ComoConectarTab.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 68),
            labelTitle1ComoConectarTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
            
        ])
        
        labelDescription1ComoConectarTab.text = HelpPopUpViewControllerStrings.Description1ComoConectarTabText.localized()
        labelDescription1ComoConectarTab.font = Fonts.bodyFont
        labelDescription1ComoConectarTab.textColor = ColorsConstants.textColor
        labelDescription1ComoConectarTab.numberOfLines = 0
        
        contentView.addSubview(labelDescription1ComoConectarTab)
        
        labelDescription1ComoConectarTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            labelDescription1ComoConectarTab.topAnchor.constraint(equalTo: labelTitle1ComoConectarTab.bottomAnchor, constant: 12),
            labelDescription1ComoConectarTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelDescription1ComoConectarTab.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
            
        ])
        
        labelTitle2ComoConectarTab.text = HelpPopUpViewControllerStrings.Title2RegrasTabText.localized()
        labelTitle2ComoConectarTab.font = Fonts.titleFont
        labelTitle2ComoConectarTab.textColor = ColorsConstants.tittlesColor
        
        contentView.addSubview(labelTitle2ComoConectarTab)
        
        labelTitle2ComoConectarTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            labelTitle2ComoConectarTab.topAnchor.constraint(equalTo: labelDescription1ComoConectarTab.bottomAnchor, constant: 24),
            labelTitle2ComoConectarTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
            
        ])
        
        labelDescription2ComoConectarTab.text = HelpPopUpViewControllerStrings.Description2ComoConectarTabText.localized()
        labelDescription2ComoConectarTab.font = Fonts.bodyFont
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
        
        let labelTitle1CreditosTab: UILabel = UILabel()
        let stackViewCreditosTab = UIStackView()
        
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
        
        labelTitle1CreditosTab.text = HelpPopUpViewControllerStrings.Title1CreditosTabText.localized()
        labelTitle1CreditosTab.font = Fonts.titleFont
        labelTitle1CreditosTab.textColor = ColorsConstants.tittlesColor
        
        contentView.addSubview(labelTitle1CreditosTab)
        
        labelTitle1CreditosTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            labelTitle1CreditosTab.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 68),
            labelTitle1CreditosTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
        ])
    
        contentView.addSubview(stackViewCreditosTab)
        
        stackViewCreditosTab.alignment = .leading
        stackViewCreditosTab.distribution = .equalSpacing
        stackViewCreditosTab.spacing = 12
        stackViewCreditosTab.axis = .vertical
        
   
        if !CreditosTabAlreadyAcessed {
            for developerName in developers {
                let label = UILabel()
                label.font = Fonts.bodyFont
                label.textColor = ColorsConstants.textColor
                label.numberOfLines = 1
                label.text = developerName
                stackViewCreditosTab.addArrangedSubview(label)
            }
        }
        
        stackViewCreditosTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            stackViewCreditosTab.topAnchor.constraint(equalTo: labelTitle1CreditosTab.bottomAnchor, constant: 26),
            stackViewCreditosTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
            
        ])
        
        CreditosTabAlreadyAcessed = true
    }
}
