//
//  String+extention.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 27/05/2024.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    var makeItBool: Bool {
        if self == "1" {
            return true
        } else {
            return false
        }
    }
}

extension Bool {
    var makeItString: String {
        if self  {
            return "1"
        }else {
            return "0"
        }
    }
}
