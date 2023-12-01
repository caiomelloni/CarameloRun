//
//  MenuInicialViewStrings.swift
//  CarameloRun
//
//  Created by Pamella Alvarenga on 01/12/23.
//

import Foundation


enum MenuInicialViewStrings: String {
    
    case helpButtonImage = "helpButtonImage"
    
    case logoImage = "logoImage"
    
    case startButtonImagem =  "startButtonImage"
    
    func localized() -> String { rawValue.localized() }
}
