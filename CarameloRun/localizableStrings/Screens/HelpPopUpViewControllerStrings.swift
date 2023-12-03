//
//  HelpPopUpViewStrings.swift
//  CarameloRun
//
//  Created by Pamella Alvarenga on 30/11/23.
//

import Foundation


enum HelpPopUpViewControllerStrings: String {
    
    case Title1RegrasTabText = "Title1RegrasTabText"
    case Description1RegrasTabText = "Description1RegrasTabText"
    
    case Title2RegrasTabText = "Title2RegrasTabText"
    case Description2RegrasTabText = "Description2RegrasTabText"
    
    case Title1ControlesTabText = "Title1ControlesTabTex"
    
    case Title1ComoConectarTabText = "Title1ComoConectarTabText"
    case Description1ComoConectarTabText = "Description1ComoConectarTabText"
    
    case Title2ComoConectarTabText = "Title2ComoConectarTabText"
    case Description2ComoConectarTabText = "Description2ComoConectarTabText"
    
    case Title1CreditosTabText = "Title1CreditosTabText"

    func localized() -> String { rawValue.localized() }
}
