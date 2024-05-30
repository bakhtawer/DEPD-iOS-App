//
//  UiButton+extention.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 23/05/2024.
//

import UIKit

extension UIButton {
    
    func makeItThemePrimary(_ fontSize: CGFloat = 20.0) {
        self.setRoundBorderColor(.clear, 0.0, 5.0)
        self.backgroundColor = .buttonBG
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
    
    func makeItThemePrimaryWhite(_ fontSize: CGFloat = 18.0) {
//        self.setRoundBorderColor(.clear, 0.0, self.viewHeight.half)
//        self.backgroundColor = .appBG
//        self.titleLabel?.font =  UIFont(name: THEMEFONTS.DDINBold.rawValue, size: fontSize)
//        self.setTitleColor(.themeGrayText, for: .normal)
    }
    
    
    func styleButton(_ fontSize: CGFloat = 20.0, _ color: UIColor = .textLight, _ fontType: APPFontType = .bold) {
        // Set font family, size, and weight
        let font = UIFont(name: fontType.rawValue, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .regular)
        self.titleLabel?.font = font
        
        self.setTitleColor(color, for: .normal)
        
        // Create a paragraph style for the line height
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 23.44
        paragraphStyle.maximumLineHeight = 23.44
        paragraphStyle.alignment = .center
        
        // Apply the paragraph style to the button's attributed title
        if let title = self.title(for: .normal) {
            let attributedTitle = NSMutableAttributedString(string: title)
            attributedTitle.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedTitle.length))
            
            self.setAttributedTitle(attributedTitle, for: .normal)
        }
    }
}
