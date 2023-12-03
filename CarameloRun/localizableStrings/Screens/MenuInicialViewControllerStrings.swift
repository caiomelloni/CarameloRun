//
//  MenuInicialViewControllerStrings.swift
//  CarameloRun
//
//  Created by Pamella Alvarenga on 03/12/23.
//

import Foundation


enum MenuInicialViewControllerStrings: String {
    
    case LogoImage = "LogoImage"
    
    case HelpButtonImage = "HelpButtonImage"
    
    case StartButtonImage = "StartButtonImage"
    
    case ConnectionStatusLabelTextNotConnected = "ConnectionStatusLabelTextNotConnected"
    
    case ConnectionStatusLabelTextConnected = "ConnectionStatusLabelTextConnected"
    
    
    func localized() -> String { rawValue.localized() }
    
}
