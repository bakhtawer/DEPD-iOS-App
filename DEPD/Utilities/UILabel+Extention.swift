//
//  UILabel+Extention.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 27/05/2024.
//

import UIKit

enum APPFontType: String {
    case bold = "Roboto-Bold"
    case light = "Roboto-Thin"
    case regular = "Roboto-Regular"
    case medium = "Roboto-Medium"
//        - "Roboto-Regular"
//        - "Roboto-Italic"
//        - "Roboto-Thin"
//        - "Roboto-ThinItalic"
//        - "Roboto-Light"
//        - "Roboto-LightItalic"
//        - "Roboto-Medium"
//        - "Roboto-MediumItalic"
//        - "Roboto-Bold"
//        - "Roboto-BoldItalic"
//        - "Roboto-Black"
//        - "Roboto-BlackItalic"
    
}

extension UILabel {
    
    func makeItTheme(_ fontType: APPFontType = .bold,
                     _ size: CGFloat = 24,
                     _ color: UIColor = .textDark,
                     _ lightHight: CGFloat = 14.0) {
        
        // Set font family, size, and weight
//        self.font = UIFont(name: fontType.rawValue,
//                           size: size) ?? UIFont.boldSystemFont(ofSize: size)
        
//        self.font = UIFont.preferredFont(forTextStyle: .title1)
        
        var lineHight = lightHight
        var textSize = size
        if UserDefaults.selectedLanguage ==  "ur" || UserDefaults.selectedLanguage ==  "sd" {
            lineHight = lightHight * 1.5
            textSize = size
            self.textAlignment = .right
        } else {
            lineHight = lightHight
            // Set text alignment
            self.textAlignment = .left
            textSize = size
        }
        
        switch UserDefaults.selectedAccessibility {
        case 1: textSize = textSize*1.2
        case 2: textSize = textSize*1.5
        case 3: textSize = textSize*1.6
        default: break
        }
        
        if UserDefaults.selectedLanguage ==  "ur" || UserDefaults.selectedLanguage ==  "sd" {
            UILabel.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UILabel.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        let textStyle: UIFont.TextStyle
        switch fontType {
        case .bold:
            textStyle = .title2
            self.font = UIFont.robotoDynamic(forTextStyle: textStyle, weight: .bold, size: textSize)
        case .light:
            textStyle = .subheadline
            self.font = UIFont.robotoDynamic(forTextStyle: textStyle, weight: .light, size: textSize)
        case .regular:
            textStyle = .body
            self.font = UIFont.robotoDynamic(forTextStyle: textStyle, weight: .regular, size: textSize)
        case .medium:
            textStyle = .title2
            self.font = UIFont.robotoDynamic(forTextStyle: textStyle, weight: .semibold, size: textSize)
        }
        
        // Set text color
        self.textColor = color
        
        
        // Create a paragraph style for the line height
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHight
        paragraphStyle.alignment = .center
        
        // Apply the paragraph style to the label's attributed text
        if let text = self.text {
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
            self.attributedText = attributedText
        }
    }
}

extension UIFont {
    static func robotoDynamic(forTextStyle textStyle: UIFont.TextStyle, 
                              weight: UIFont.Weight = .regular,
                              size: CGFloat = 24) -> UIFont {
        let size = size //UIFont.preferredFont(forTextStyle: textStyle).pointSize
        let font: UIFont
        
        if UserDefaults.selectedLanguage ==  "ur" {
            font = UIFont(name: "Lateefi-Regular-Urdu", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
        }
        else if UserDefaults.selectedLanguage ==  "sd" {
            font = UIFont(name: "Jameel-Noori-Sindhi", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
        } else {
            switch weight {
            case .bold:
                font = UIFont(name: "Roboto-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
            case .light:
                font = UIFont(name: "Roboto-Thin", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
            default:
                font = UIFont(name: "Roboto-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
            }
        }

        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
    }
}
