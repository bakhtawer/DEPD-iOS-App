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
}
