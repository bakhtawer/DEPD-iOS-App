//
//  UiButton+extention.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 23/05/2024.
//

import UIKit

extension UIButton {
    
    func makeItThemePrimary(_ fontSize: CGFloat = 18.0) {
        self.setRoundBorderColor(.clear, 0.0, 5.0)
        self.backgroundColor = .buttonBG
        styleButton(fontSize, .appLight, .regular)
        self.applyShadow()
    }
    
    func makeItThemeGreenPrimary(_ fontSize: CGFloat = 18.0) {
        self.setRoundBorderColor(.clear, 0.0, 5.0)
        self.backgroundColor = .appGreen
        styleButton(fontSize, .appLight, .regular)
        self.applyShadow()
    }
    
    func makeItThemeLargeWhite(_ fontSize: CGFloat = 24.0,
                               _ textColor: UIColor = .darkText) {
        self.setRoundBorderColor(.clear, 0.0, 11)
        self.backgroundColor = .appLight
        self.titleLabel?.font = .systemFont(ofSize: fontSize, weight: .medium)  //UIFont(name: THEMEFONTS.DDINBold.rawValue, size: fontSize)
        self.setTitleColor(textColor, for: .normal)
        self.applyShadow()
    }
    
    func makeItThemeLargeTransBlack(_ fontSize: CGFloat = 24.0,
                               _ textColor: UIColor = .darkText) {
        self.setRoundBorderColor(.appBorder, 0.0, 11)
        self.backgroundColor = .appLight
        self.titleLabel?.font = .systemFont(ofSize: fontSize, weight: .medium)  //UIFont(name: THEMEFONTS.DDINBold.rawValue, size: fontSize)
        self.setTitleColor(textColor, for: .normal)
        self.applyShadow()
    }
    
    func makeItThemeRegular(_ fontSize: CGFloat = 24.0,
                            _ textColor: UIColor = .darkText,
                            _ bgColor: UIColor = .appBG) {
        self.setRoundBorderColor(.clear, 0.0, 6)
        self.backgroundColor = bgColor
//        styleButton(fontSize, textColor, .regular)
//        self.applyShadow()
    }
    
    func makeItThemePrimaryWhite(_ fontSize: CGFloat = 18.0) {
//        self.setRoundBorderColor(.clear, 0.0, self.viewHeight.half)
//        self.backgroundColor = .appBG
//        self.titleLabel?.font =  UIFont(name: THEMEFONTS.DDINBold.rawValue, size: fontSize)
//        self.setTitleColor(.themeGrayText, for: .normal)
    }
    
    
    func styleButton(_ fontSize: CGFloat = 18.0, _ color: UIColor = .textLight, _ fontType: APPFontType = .bold) {
        var reSize = fontSize
        
        switch UserDefaults.selectedAccessibility {
        case 1: reSize = reSize*1.2
        case 2: reSize = reSize*1.4
        case 3: reSize = reSize*1.6
        default: break
        }
        
        if UserDefaults.selectedLanguage ==  "ur" || UserDefaults.selectedLanguage ==  "sd" {
            reSize = reSize - 1
        }
        
        // Set font family, size, and weight
        let font = UIFont(name: fontType.rawValue, size: reSize) ?? UIFont.systemFont(ofSize: reSize, weight: .regular)
        self.titleLabel?.font = font
        
        self.setTitleColor(color, for: .normal)
        
        // Create a paragraph style for the line height
        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.minimumLineHeight = 23.44
//        paragraphStyle.maximumLineHeight = 23.44
        paragraphStyle.alignment = .center
        
        // Apply the paragraph style to the button's attributed title
        if let title = self.title(for: .normal) {
            let attributedTitle = NSMutableAttributedString(string: title)
            attributedTitle.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedTitle.length))
            
            self.setAttributedTitle(attributedTitle, for: .normal)
        }
    }
}
