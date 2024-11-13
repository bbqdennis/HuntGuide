//
//  PlanetXFont.swift
//  HuntGuide
//
//  Created by Dennis Cheng on 13/11/2024.
//

import UIKit

class PlanetXFont {
    
    // MARK: - Font Names
    private static let primaryFontName = "Helvetica Neue Bold"  // 替換為自定義的主要字體名稱
    private static let fallbackFontName = "HelveticaNeue"     // 當主要字體無法加載時的備用字體
    
    // MARK: - Font Sizes
    static func titleFont(size: CGFloat = 14) -> UIFont {
        return customFont(name: primaryFontName, size: size, weight: .bold)
    }
    
    static func descriptionFont(size: CGFloat = 11) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }

    // MARK: - Private Helper Function
    private static func customFont(name: String, size: CGFloat, weight: UIFont.Weight) -> UIFont {
        if let customFont = UIFont(name: name, size: size) {
            return customFont
        } else {
            // 使用系統字體作為備選方案
            return UIFont.systemFont(ofSize: size, weight: weight)
        }
    }
}
