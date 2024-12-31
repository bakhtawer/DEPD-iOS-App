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
        // Define the updated pattern
        let pattern = #"/Date\((\d+)\)/"#
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            print("Regex creation failed")
            return nil
        }
        
        // Match the regex
        guard let match = regex.firstMatch(in: self, range: NSRange(self.startIndex..., in: self)),
              let range = Range(match.range(at: 1), in: self) else {
            print("No match found in: \(self)")
            return nil
        }
        
        // Extract milliseconds
        let millisecondsString = self[range]
        print("Extracted milliseconds: \(millisecondsString)")
        
        guard let milliseconds = Double(millisecondsString) else {
            print("Failed to convert milliseconds to Double")
            return nil
        }
        
        // Convert to Date
        let date = Date(timeIntervalSince1970: milliseconds / 1000)
        print("Converted Date: \(date)")
        
        // Format the date
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
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
