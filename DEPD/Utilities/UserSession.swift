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
    
    private let service = APIService()
    
    func setUser(user: User) {
        self.user = user
    }
    func getUser() -> User {
        self.user
    }
    
    func getUserFullName() -> String {
        "\(self.user.firstName ?? "Guest") \(self.user.lastName ?? "User")"
    }
    
    func getUserImage() -> String {
        self.user.oStudentDetails?.profilePictureURL?.convertToHttps() ?? ""
    }
    func LogoutUser(){
        KeychainManager.nuke()
        self.user = User()
    }
}

extension UserSessionManager {
    func login(email: String, Password: String) {
        let request = Endpoint.login(email: email, password: Password).request!
        service.makeRequest(with: request, respModel: ApiResponse<User>.self) {userResponse, error in
            if let error = error { print("DEBUG PRINT:", error); return }
            print("DEBUG PRINT:", userResponse ?? "")
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                KeychainManager.nuke()
                DispatchQueue.main.async { Bootstrapper.createSplash()}
                return }
            guard let user = userResponse?.oData else {
                SMM.shared.showError(title: "", message: "Error parsing server response.");
                KeychainManager.nuke()
                DispatchQueue.main.async { Bootstrapper.createSplash()}
                return}
            UserSessionManager.shared.setUser(user: user)
            DispatchQueue.main.async { Bootstrapper.createHome()}
        }
    }
}

extension UserSessionManager {
    func update(student: StudentDetails?, completion: @escaping (Bool) -> Void) {
        var user = USM.shared.user
        user.oStudentDetails = student
        print(user)
        let request = Endpoint.updateProfile(creds: user).request!
        service.makeRequest(with: request, respModel: ApiResponse<User>.self) {userResponse, error in
            if let error = error {
                print("DEBUG PRINT:", error);
                completion(false)
                return }
            print("DEBUG PRINT:", userResponse ?? "")
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                completion(false)
                return }
            guard let user = userResponse?.oData else {
                SMM.shared.showError(title: "", message: "Error parsing server response.");
                completion(false)
                return}
            completion(true)
            SMM.shared.showStatusSuccess(message: "Profile Updated")
            UserSessionManager.shared.setUser(user: user)
        }
    }
}
