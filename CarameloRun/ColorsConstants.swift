//
//  ColorsConstants.swift
//  CarameloRun
//
//  Created by Pamella Alvarenga on 30/11/23.
//

import Foundation
import UIKit

struct ColorsConstants {
    
    static let backgroundColor = UIColor(red: 232.0/255.0, green: 214.0/255.0, blue: 166.0/255.0, alpha: 1.0)
    static let buttonColor = UIColor(_colorLiteralRed: 215.0/255.0, green: 94.0/255.0, blue: 64.0/255.0, alpha: 1.0)
    static let tittlesColor = UIColor(red: 215.0/255.0, green: 94.0/255.0, blue: 64.0/255.0, alpha: 1.0)
    static let textColor = UIColor(red: 32.0/255.0, green: 46.0/255.0, blue: 55.0/255.0, alpha: 1.0)
    static let connectedColor = UIColor(red: 45.0/255.0, green: 77.0/255.0, blue: 45.0/255.0, alpha: 1.0)
    
    static let menuBackgroundImage: UIColor = {
        guard let backgroundImage = Images.menuBackgroundImage else {
            // Defina uma cor padrão se a imagem for nula
            return backgroundColor
        }
        return UIColor(patternImage: backgroundImage)
    }()

   
    
    static let selectedSegment = UIColor(red: 255.0/255.0, green: 240.0/255.0, blue: 199.0/255.0, alpha: 1.0)
    static let unselectedSegment = UIColor(red: 232.0/255.0, green: 214.0/255.0, blue: 166.0/255.0, alpha: 1.0)


}
