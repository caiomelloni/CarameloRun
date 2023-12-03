//
//  String+Localizable.swift
//  CarameloRun
//
//  Created by Pamella Alvarenga on 30/11/23.
//

import Foundation

extension String {
    func localized(_ screen: ScreenChoice = .HelpPopUpViewControllerStrings) -> String {
        
        var fileName = String()
        
        switch screen{
            
        case .PreparingViewControllerStrings:
            fileName = "PreparingViewControllerStrings"
            
        case .MenuInicialViewControllerStrings:
            fileName = "MenuInicialViewControllerStrings"
            
        case .HelpPopUpViewControllerStrings:
            fileName = "HelpPopUpViewControllerStrings"
        }
        return NSLocalizedString(self, tableName: fileName, bundle: Bundle.main, value: String(), comment: String())
    }
}
