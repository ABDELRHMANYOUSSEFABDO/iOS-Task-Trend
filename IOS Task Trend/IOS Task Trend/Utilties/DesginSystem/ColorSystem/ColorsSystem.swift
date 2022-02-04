//
//  Colors.swift
//  DadNSale
//
//  Created by Mahmoud Alaa on 12/02/2021.
//

import Foundation
import UIKit


struct DesignSystem {
    enum Colors: String {
        case primary = "Primary"
        case darkPrimary = "DarkPrimary"
        case lightPrimary = "LightPrimary"
        case grayPrimary = "GrayPrimary"
        case lightGrayPrimary = "LightGrayPrimary"
        case border = "Border"
        case mediumGray = "MediumGray"
        case grayDark = "GrayDark"
        case placeHolderPrimary = "PlaceHolderPrimary"
        
        var color: UIColor{
            return UIColor(named: self.rawValue) ?? .white
        }
    }
}
