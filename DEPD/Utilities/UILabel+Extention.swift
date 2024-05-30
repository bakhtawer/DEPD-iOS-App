//
//  UILabel+Extention.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 27/05/2024.
//

import UIKit

enum APPFontType: String {
    case bold = "Roboto-Bold"
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
                     _ lightHight: CGFloat = 28.13) {
        
        // Set font family, size, and weight
        self.font = UIFont(name: fontType.rawValue,
                           size: size) ?? UIFont.boldSystemFont(ofSize: size)
        
        // Set text alignment
        self.textAlignment = .center
        
        // Set text color
        self.textColor = color
        
        // Create a paragraph style for the line height
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lightHight
        paragraphStyle.alignment = .center
        
        // Apply the paragraph style to the label's attributed text
        if let text = self.text {
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
            self.attributedText = attributedText
        }
    }
}
