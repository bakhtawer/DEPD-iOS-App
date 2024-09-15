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
    }}

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
        }
        // Return the original string if no change is needed
        return self
    }
}
