//
//  HelpPopUpViewStrings.swift
//  CarameloRun
//
//  Created by Pamella Alvarenga on 30/11/23.
//

import Foundation


enum HelpPopUpViewStrings: String {
    case Title1RegrasTabText = "Title1RegrasTabText"
    case Description1RegrasTabText = "Description1RegrasTabText"
    case Title2RegrasTabText = "Title2RegrasTabText"
    case Description2RegrasTabText = "Description2RegrasTabText"
    
    

    
    func localized() -> String { rawValue.localized() }
}
