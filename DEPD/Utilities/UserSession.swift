//
//  UserSession.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 07/07/2024.
//

import Foundation

protocol UserSession: AnyObject {
    func setUser(user: User)
    func getUser() -> User
    func getUserFullName() -> String
}

typealias USM = UserSessionManager
class UserSessionManager: UserSession {
    static let shared = UserSessionManager()

    private var user: User = User()
    
    private init() {}
    
    func setUser(user: User) {
        self.user = user
    }
    func getUser() -> User {
        self.user
    }
    
    func getUserFullName() -> String {
        "\(self.user.firstName ?? "Guest") \(self.user.lastName ?? "User")"
    }
}
