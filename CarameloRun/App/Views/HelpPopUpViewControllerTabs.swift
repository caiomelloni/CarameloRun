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
        
        setLabel(labelTitle1RegrasTab, Fonts.titleFont, ColorsConstants.tittlesColor, numberOfLines: 0, text: HelpPopUpViewControllerStrings.Title1RegrasTabText.localized())
        setLabel(labelDescription1RegrasTab, Fonts.bodyFont, ColorsConstants.textColor, numberOfLines: 0, text: HelpPopUpViewControllerStrings.Description1RegrasTabText.localized())
        setLabel(labelTitle2RegrasTab, Fonts.titleFont, ColorsConstants.tittlesColor, numberOfLines: 0, text: HelpPopUpViewControllerStrings.Title2RegrasTabText.localized())
        setLabel(labelDescription2RegrasTab, Fonts.bodyFont, ColorsConstants.textColor, numberOfLines: 0, text: HelpPopUpViewControllerStrings.Description2RegrasTabText.localized())
        
        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(equalTo: self.canvas.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.canvas.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.canvas.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.canvas.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: self.canvas.widthAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
            
            labelTitle1RegrasTab.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 68),
            labelTitle1RegrasTab.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24)
            
        ])
        
        NSLayoutConstraint.activate([
            
            labelDescription1RegrasTab.topAnchor.constraint(equalTo: labelTitle1RegrasTab.bottomAnchor, constant: 12),
            labelDescription1RegrasTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            labelDescription1RegrasTab.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
            
        ])
        
        NSLayoutConstraint.activate([
            
            labelTitle2RegrasTab.topAnchor.constraint(equalTo: labelDescription1RegrasTab.bottomAnchor, constant: 24),
            labelTitle2RegrasTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24)
            
        ])
        
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
        
        setLabel(labelTitle1ControlesTab, Fonts.titleFont, ColorsConstants.tittlesColor, numberOfLines: 0, text: HelpPopUpViewControllerStrings.Title1ControlesTabText.localized())
        
        NSLayoutConstraint.activate([
            
            labelTitle1ControlesTab.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 68),
            labelTitle1ControlesTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
            
        ])
    
        
        
        contentView.addSubview(stackViewControlesTab)
        
        stackViewControlesTab.alignment = .center
        stackViewControlesTab.distribution = .equalSpacing
        stackViewControlesTab.spacing = 0
        stackViewControlesTab.axis = .vertical
           
        

            stackViewControlesTab.addArrangedSubview(jumpView)
            stackViewControlesTab.addArrangedSubview(leftView)
            stackViewControlesTab.addArrangedSubview(rightView)
     
        stackViewControlesTab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackViewControlesTab.topAnchor.constraint(equalTo: labelTitle1ControlesTab.bottomAnchor, constant: 26),
            stackViewControlesTab.widthAnchor.constraint(equalToConstant: 150),
            stackViewControlesTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            stackViewControlesTab.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
        
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
        
        setLabel(labelTitle1ComoConectarTab, Fonts.titleFont, ColorsConstants.tittlesColor, numberOfLines: 0, text: HelpPopUpViewControllerStrings.Title1ComoConectarTabText.localized())
        
        NSLayoutConstraint.activate([
            
            labelTitle1ComoConectarTab.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 68),
            labelTitle1ComoConectarTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
            
        ])
        
        setLabel(labelDescription1ComoConectarTab, Fonts.bodyFont, ColorsConstants.textColor, numberOfLines: 0, text: HelpPopUpViewControllerStrings.Description1ComoConectarTabText.localized())
        
        NSLayoutConstraint.activate([
            
            labelDescription1ComoConectarTab.topAnchor.constraint(equalTo: labelTitle1ComoConectarTab.bottomAnchor, constant: 12),
            labelDescription1ComoConectarTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            labelDescription1ComoConectarTab.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
            
        ])
        
        setLabel(labelTitle2ComoConectarTab, Fonts.titleFont, ColorsConstants.tittlesColor, numberOfLines: 0, text: HelpPopUpViewControllerStrings.Title2RegrasTabText.localized())
        
        NSLayoutConstraint.activate([
            
            labelTitle2ComoConectarTab.topAnchor.constraint(equalTo: labelDescription1ComoConectarTab.bottomAnchor, constant: 24),
            labelTitle2ComoConectarTab.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
            
        ])
        
        setLabel(labelDescription2ComoConectarTab, Fonts.bodyFont, ColorsConstants.textColor, numberOfLines: 0, text: HelpPopUpViewControllerStrings.Description2ComoConectarTabText.localized())
        
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
        
        setLabel(labelTitle1CreditosTab, Fonts.titleFont, ColorsConstants.tittlesColor, numberOfLines: 0, text: HelpPopUpViewControllerStrings.Title1CreditosTabText.localized())
        
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
    
    func setLabel(_ customLabel: UILabel, _ font: UIFont?, _ color: UIColor?, numberOfLines: Int, text: String?) {
        customLabel.text = text
        customLabel.font = font
        customLabel.textColor = color
        customLabel.numberOfLines = numberOfLines
        customLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView.addSubview(customLabel)
    }
}
