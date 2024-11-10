//
//  String+extentions.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 22/05/2024.
//

import Foundation

extension String {
    func localized(_ lang:String = UserDefaults.selectedLanguage) ->String {
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    /// Converts a date string from "d MMM yyyy" format to "dd/MM/yyyy" format.
    func toFormattedDate() -> String? {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "d MMM yyyy" // Matches "8 Nov 2022"
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "MM/dd/yyyy" // Desired format
        
        if let date = inputDateFormatter.date(from: self) {
            return outputDateFormatter.string(from: date)
        }
        
        return nil // Return nil if the date could not be parsed
    }
    
    func toFormattedDateShow() -> String? {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "MM/dd/yyyy"  // Matches "8 Nov 2022"
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "d MMM yyyy" // Desired format
        
        if let date = inputDateFormatter.date(from: self) {
            return outputDateFormatter.string(from: date)
        }
        
        return nil // Return nil if the date could not be parsed
    }
    
    func fromFormattedDate() -> Date? {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "MM/dd/yyyy"  // Matches "8 Nov 2022"
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "d MMM yyyy" // Desired format
        
        if let date = inputDateFormatter.date(from: self) {
            return date
        }
        
        return nil
    }
    
    /// Checks if the date string is at least 18 years from the current date.
    func isAbove18() -> Bool {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "MM/dd/yyyy"
        
        guard let dateOfBirth = inputDateFormatter.date(from: self) else {
            return false // Return false if the date string is invalid
        }
        
        let calendar = Calendar.current
        if let ageLimitDate = calendar.date(byAdding: .year, value: 18, to: dateOfBirth) {
            return Date() >= ageLimitDate
        }
        
        return false
    }
}

extension Date {
    func toFormattedDate() -> String? {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "d MMM yyyy" // Matches "8 Nov 2022"
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "MM/dd/yyyy" // Desired format
        let dateString = outputDateFormatter.string(from: self)
        return dateString
    }
}

extension Bundle {
    private static var bundle: Bundle!
    
    public static func localizedBundle() -> Bundle! {
        if bundle == nil {
            let appLang = UserDefaults.standard.string(forKey: "app_lang") ?? "ru"
            let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
            bundle = Bundle(path: path!)
        }
        
        return bundle;
    }
    
    public static func setLanguage(lang: String) {
        UserDefaults.standard.set(lang, forKey: "AppleLanguages")
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        bundle = Bundle(path: path!)
    }
}

extension String {
    /// Converts an HTTP URL to HTTPS if it starts with "http://".
    func convertToHttps() -> String {
        // Check if the string starts with "http://"
        if self.hasPrefix("http://") {
            // Replace "http://" with "https://"
            return self.replacingOccurrences(of: "http://", with: "https://")
        } else {
            return "https://hub.depdportal.com/" + self
        }
        // Return the original string if no change is needed
        return self
    }
}
