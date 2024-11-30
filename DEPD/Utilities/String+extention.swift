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
    
    var convertMicrosoftDateString: String? {
        // Remove the "\/Date(" prefix and ")\/" suffix
        let trimmedString = self
            .replacingOccurrences(of: "\\/Date(", with: "")
            .replacingOccurrences(of: ")\\/", with: "")
        
        // Convert to milliseconds
        if let milliseconds = Int64(trimmedString) {
            // Convert milliseconds to seconds and create a Date object
            let date = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
            
            // Format the Date object
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            // Return the formatted date
            return dateFormatter.string(from: date)
        }
        
        // Return nil if parsing fails
        return nil
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
    
    var makeItInt: Int {
        if self  {
            return 1
        }else {
            return 0
        }
    }
}
