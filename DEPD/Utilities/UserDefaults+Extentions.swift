//
//  UserDefaults+Extentions.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 22/05/2024.
//

import Foundation

extension UserDefaults {
    
    struct Keys {
        // MARK: - Constants
        static let selectedLanguage = "selectedLanguage"
        static let selectedAccessibility = "selectedAccessibility"
        static let firstTimeUser = "firstTimeUser"
    }
    
    // MARK: - Language
    class var selectedLanguage: String {
        let storedValue = UserDefaults.standard.string(forKey: UserDefaults.Keys.selectedLanguage) ?? "en"
        return storedValue
    }
    
    class func set(selectedLanguage: String) {
        UserDefaults.standard.set(selectedLanguage, forKey: UserDefaults.Keys.selectedLanguage)
    }
    
    // MARK: - FirstTimeUser
    class var firstTimeUser: Bool {
        let storedValue = UserDefaults.standard.bool(forKey: UserDefaults.Keys.firstTimeUser)
        return storedValue
    }
    
    class func set(firstTimeUser: Bool) {
        UserDefaults.standard.set(firstTimeUser, forKey: UserDefaults.Keys.firstTimeUser)
    }
    
    // MARK: - Language
    class var selectedAccessibility: Int {
        let storedValue = UserDefaults.standard.integer(forKey: UserDefaults.Keys.selectedAccessibility)
        return storedValue
    }
    
    class func set(selectedAccessibility: Int) {
        UserDefaults.standard.set(selectedAccessibility, forKey: UserDefaults.Keys.selectedAccessibility)
    }
}
