//
//  UiButton+extention.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 23/05/2024.
//

import UIKit

extension UIButton {
    
    func makeItThemePrimary(_ fontSize: CGFloat = 20.0) {
        self.setRoundBorderColor(.clear, 0.0, self.viewHeight.half)
        self.backgroundColor = .buttonBG
        self.titleLabel?.font = .systemFont(ofSize: fontSize, weight: .medium)
     //UIFont(name: THEMEFONTS.DDINBold.rawValue, size: fontSize)
        self.setTitleColor(.textLight, for: .normal)
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
}
