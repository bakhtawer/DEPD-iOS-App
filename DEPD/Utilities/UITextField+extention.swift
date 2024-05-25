//
//  UITextField+extention.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 22/05/2024.
//

import UIKit

extension UITextField {
    func makeItThemeTF() {
        self.setLeftPaddingPoints(16)
        self.setRightPaddingPoints(16)
        self.textColor = .textDark
        self.backgroundColor = .appLight
        self.applyShadow()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        if UserDefaults.selectedLanguage ==  "ur" || UserDefaults.selectedLanguage ==  "sd" {
            UITextField.appearance().textAlignment = .right
        } else {
            UITextField.appearance().textAlignment = .left
        }
    }
}


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
