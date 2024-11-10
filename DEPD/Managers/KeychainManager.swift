//
//  KeychainManager.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 10/11/2024.
//


import Foundation
import Security

class KeychainManager {
    
    enum Keys: String {
        case cnic
        case password
        case userType
    }
    
    // MARK: - Save to Keychain
    @discardableResult
    static func save(_ value: String, forKey key: Keys) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        
        // Define keychain query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecValueData as String: data
        ]
        
        // Delete existing item if it exists
        SecItemDelete(query as CFDictionary)
        
        // Add new item to keychain
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    // MARK: - Retrieve from Keychain
    static func retrieve(forKey key: Keys) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Data {
            return String(data: data, encoding: .utf8)
        }
        
        return nil
    }
    
    // MARK: - Delete from Keychain
    static func delete(forKey key: Keys) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
    
    // MARK: - Delete from Keychain
    static func nuke() {
        delete(forKey: .cnic)
        delete(forKey: .password)
        delete(forKey: .userType)
    }
}
