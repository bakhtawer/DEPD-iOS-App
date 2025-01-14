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
        switch AMDH.shared.userType {
        case .Student:
            self.user.oStudentDetails?.profilePictureURL?.convertToHttps() ?? ""
        case .School:
            self.user.schoolDetailInfo?.profileImageURL?.convertToHttps() ?? ""
        case .JobSeeker:
            self.user.jobSeekerDetailInfo?.profilePicture?.convertToHttps() ?? ""
        case .Employer:
            self.user.companyDetailInfo?.companyImageURL?.convertToHttps() ?? ""
        case .StudentGuest:
            ""
        case .JobSeekerGuest:
            ""
        }
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
            if let error = error { print("DEBUG PRINT:", error);
                KeychainManager.nuke()
                DispatchQueue.main.async { Bootstrapper.createSplash()}
                return }
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
    
    func getUserProfile(completion: @escaping (Bool) -> Void) {
        if let userID = Int(KeychainManager.retrieve(forKey: .userID) ?? "-1"), userID != -1 {
        let request = Endpoint.getUser(cred: GetUserByID(Id: userID)).request!
            service.makeRequest(with: request, respModel: ApiResponse<User>.self) {userResponse, error in
                func fail() {
                    completion(false)
                }
                if let error = error { print("DEBUG PRINT:", error);
                    fail()
                    return }
                print("DEBUG PRINT:", userResponse ?? "")
                if let error = userResponse?.isError, error {
                    SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                    fail()
                    return }
                guard let user = userResponse?.oData else {
                    fail()
                    return}
                UserSessionManager.shared.setUser(user: user)
                completion(true)
            }
        }
    }
}

extension UserSessionManager {
    func update(student: StudentUpdateDetails, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.updateProfile(creds: student).request!
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

extension UserSessionManager {
    func getApplications(completion: @escaping ([MyApplicationsModel]?) -> Void) {
        if let userID = Int(KeychainManager.retrieve(forKey: .userID) ?? "-1"), userID != -1 {
        let request = Endpoint.getApplications(cred: GetUserByID(Id: userID)).request!
            service.makeRequest(with: request, respModel: MyApplicationsContainer.self) {userResponse, error in
                func fail() {
                    completion([])
                }
                if let error = error { print("DEBUG PRINT:", error);
                    fail()
                    return }
                print("DEBUG PRINT:", userResponse ?? "")
                if let error = userResponse?.isError, error {
                    SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                    fail()
                    return }
                guard let data = userResponse?.oData else {
                    fail()
                    return}
                completion(data)
            }
        }
    }
}

extension UserSessionManager {
    func getJobSeeker(userID: Int, completion: @escaping (User?) -> Void) {
            let request = Endpoint.getAuth(cred: GetUserByID(Id: userID), method: "getJobSeeker").request!
            service.makeRequest(with: request, respModel: ApiResponse<User>.self) {userResponse, error in
                func fail() {
                    completion(nil)
                }
                if let error = error { print("DEBUG PRINT:", error);
                    fail()
                    return }
                print("DEBUG PRINT:", userResponse ?? "")
                if let error = userResponse?.isError, error {
                    SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                    fail()
                    return }
                guard let data = userResponse?.oData else {
                    fail()
                    return}
                completion(data)
            }
    }
}

// Complaints
extension UserSessionManager {
    func complainForDenialOfAdmission(data: DenialOfAdmissionCreds, completion: @escaping (Bool?) -> Void) {
        let request = Endpoint.complainForDenialOfAdmission(cred: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) {userResponse, error in
                func fail() {
                    completion(nil)
                }
                if let error = error { print("DEBUG PRINT:", error);
                    fail()
                    return }
                print("DEBUG PRINT:", userResponse ?? "")
                if let error = userResponse?.isError, error {
                    SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                    fail()
                    return }
                completion(true)
            }
    }
    
    func complainForDenialOfJob(data: DenialOfAdmissionCreds, completion: @escaping (Bool?) -> Void) {
        let request = Endpoint.complainForDenialOfJob(cred: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) {userResponse, error in
                func fail() {
                    completion(nil)
                }
                if let error = error { print("DEBUG PRINT:", error);
                    fail()
                    return }
                print("DEBUG PRINT:", userResponse ?? "")
                if let error = userResponse?.isError, error {
                    SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                    fail()
                    return }
                completion(true)
            }
    }
    
    func generalComplain(data: GeneralComplainCreds, completion: @escaping (Bool?) -> Void) {
        let request = Endpoint.generalComplain(cred: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) {userResponse, error in
                func fail() {
                    completion(nil)
                }
                if let error = error { print("DEBUG PRINT:", error);
                    fail()
                    return }
                print("DEBUG PRINT:", userResponse ?? "")
                if let error = userResponse?.isError, error {
                    SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                    fail()
                    return }
                completion(true)
            }
    }
}

class GeneralComplainCreds: Codable {
    let AudioFileName: String?
    let CNICNo: String?
    let ContactNo: String?
    let DisabilityTypeId: Int?
    let District: String?
    let FullName: String?
    let Gender: String?
    let Message: String?
    init(AudioFileName: String?, CNICNo: String?, ContactNo: String?, DisabilityTypeId: Int?, District: String?, FullName: String?, Gender: String?, Message: String?) {
        self.AudioFileName = AudioFileName
        self.CNICNo = CNICNo
        self.ContactNo = ContactNo
        self.DisabilityTypeId = DisabilityTypeId
        self.District = District
        self.FullName = FullName
        self.Gender = Gender
        self.Message = Message
    }
}

struct ForgotPasswordResponse: Codable {
    var Cnic: Int?
    var Status: Bool?
}

extension UserSessionManager {
    func forgetPassword(Cnic: Int, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.getAuth(cred: GetUserByID(Cnic: Cnic), method: "forgetPassword").request!
        service.makeRequest(with: request, respModel: ApiResponse<ForgotPasswordResponse>.self) {userResponse, error in
            func fail() {
                completion(false)
            }
            if let error = error { print("DEBUG PRINT:", error);
                fail()
                return }
            print("DEBUG PRINT:", userResponse ?? "")
            if let error = userResponse?.isError, error {
                SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                fail()
                return }
            
            if let message = userResponse?.errorMessage2, !message.isEmpty {
                SMM.shared.showError(title: "", message: message);
                fail()
                return
            }
            
            guard let data = userResponse?.oData, let status2 = data.Status, status2 else {
                SMM.shared.showError(title: "", message: userResponse?.errorMessage2 ?? "Something went Wrong")
                fail()
                return
            }
            
            completion(true)
        }
    }
    
    func resetPassword(Cnic: Int, Otp: String, Pasword: String, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.getAuth(cred: GetUserByID(Cnic: Cnic, Otp: Otp, Pasword: Pasword), method: "resetPassword").request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) {userResponse, error in
            func fail() {
                completion(false)
            }
            if let error = error { print("DEBUG PRINT:", error);
                fail()
                return }
            print("DEBUG PRINT:", userResponse ?? "")
            if let error = userResponse?.isError, error {
                SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                fail()
                
                return }
            if let message = userResponse?.errorMessage2, !message.isEmpty {
                SMM.shared.showError(title: "", message: message);
                fail()
                return
            }
            completion(true)
        }
    }
    
    func verifyOtp(Cnic: Int, Otp: String, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.getAuth(cred: GetUserByID(Cnic: Cnic, Otp: Otp), method: "verifyOtp").request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) {userResponse, error in
            func fail() {
                completion(false)
            }
            if let error = error { print("DEBUG PRINT:", error);
                fail()
                return }
            print("DEBUG PRINT:", userResponse ?? "")
            if let error = userResponse?.isError, error {
                SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                fail()
                return
            }
            if  let message = userResponse?.errorMessage2, !message.isEmpty {
                SMM.shared.showError(title: "", message: message);
                fail()
                return
            }
            completion(true)
        }
    }
}
