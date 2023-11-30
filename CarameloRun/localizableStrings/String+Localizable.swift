//
//  String+Localizable.swift
//  CarameloRun
//
//  Created by Pamella Alvarenga on 30/11/23.
//

import Foundation

extension String {
    func localized(_ screen: ScreenChoice = .HelpPopUpView) -> String {
        
        var fileName = String()
        
        switch screen{
            
        case .HelpPopUpView:
            fileName = "HelpPopUpViewStrings"
            
        }
        return NSLocalizedString(self, tableName: fileName, bundle: Bundle.main, value: String(), comment: String())
    }
}
