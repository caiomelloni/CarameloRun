//
//  PreparingViewControllerStrings.swift
//  CarameloRun
//
//  Created by Pamella Alvarenga on 03/12/23.
//

import Foundation

enum PreparingViewControllerStrings: String {
    
    case ManTypePlayer = "ManTypePlayer"
    
    case DogTypePlayer = "DogTypePlayer"
    
    case ButtonTitleText = "ButtonTitleText"
    
    func localized() -> String { rawValue.localized(.PreparingViewControllerStrings) }
}
