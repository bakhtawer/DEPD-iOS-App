//
//  SchoolManager.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 11/11/2024.
//

final class SchoolManager {
    static let shared = SchoolManager()
    private init() {}
    
    private let service = APIService()
    
    var selectedSchool: InstituteModel?
    
    func fetchAllSchoolsForSchool(completion: @escaping (Bool) -> Void) {
        let request = Endpoint.getSchoolList.request!
        service.makeRequest(with: request, respModel: ApiResponse<[InstituteModel]>.self) {[weak self] userResponse, error in
            if let error = error { print("DEBUG PRINT:", error);
                completion(false)
                return }
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                completion(false)
                return }
            guard let schools = userResponse?.oData else { SMM.shared.showError(title: "", message: "Error parsing server response.");
                completion(false)
                return }
            self?.selectedSchool = schools.filter { $0.InstituteId == USM.shared.getUser().id }.last
            completion(true)
        }
    }
}

struct UploadSchoolProfile: Codable {
    let DisabilityStatusId: Int
    let UserId: Int
}
extension SchoolManager {
    // MARK: UploadSchoolProfile
    func insertDisabilityStatus(disabilityStatusID:Int, completion: @escaping (Bool) -> Void) {
    }
}

//case updatePersonalInformation(cred: Codable)
struct UpdatePersonalInformation: Codable {
    var SchoolId: Int?
    var SchoolName: String?
    var NTNNumber: String?
    var oUser: oUser?
    struct oUser: Codable {
        var Id: Int?
        var FirstName: String?
        var LastName: String?
        var CNIC: String?
        var ContactNo: String?
        var EmailAddress: String?
        var Designation: String?
    }
}
extension SchoolManager {
    // MARK: UpdatePersonalInformation
    func updatePersonalInformation(data: UpdatePersonalInformation, completion: @escaping (Bool) -> Void) {
    }
}


//case updateAboutYourSchool(cred: Codable)
struct UpdateAboutYourSchool: Codable {
    var SchoolId: Int
    var AboutText: String
}
extension SchoolManager {
    // MARK: UpdateAboutYourSchool
    func updateAboutYourSchool(data: UpdateAdditionalInfoCreds, completion: @escaping (Bool) -> Void) {
    }
}


//case updateAdditionalInfo(cred: Codable)
extension SchoolManager {
    // MARK: updateAdditionalInfo
    func updateAdditionalInfo(data: UpdateAdditionalInfoCreds, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.updateAdditionalInfo(cred: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) {userResponse, error in
            if error != nil {
                completion(false)
                return }
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                completion(false)
                return }
            completion(true)
        }
    }
}

//case insertSocialMediaLink(cred: Codable)
struct InsertSocialMediaLink: Codable {
    var AccountTypeID: Int
    var RelID: Int
    var SocialMediaLink: String
}
extension SchoolManager {
    // MARK: insertSocialMediaLink
    func insertSocialMediaLink(data: InsertSocialMediaLink, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.insertSocialMediaLink(cred: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) {userResponse, error in
            if let error = error {
                print("DEBUG PRINT:", error);
                completion(false)
                return }
            print("DEBUG PRINT:", userResponse ?? "")
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                completion(false)
                return }
            completion(true)
        }
    }
}

//case deleteSocialMediaLink(cred: Codable)
struct DeleteById: Codable {
    var Id: Int
    var UserId: Int
}
extension SchoolManager {
    // MARK: deleteSocialMediaLink
    func deleteSocialMediaLink(data: DeleteById, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.deleteSocialMediaLink(cred: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) {userResponse, error in
            if error != nil {
                completion(false)
                return }
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                completion(false)
                return }
            completion(true)
        }
    }
}


//case insertSocialMultiMedia(cred: Codable)
struct InsertSocialMultiMedia: Codable {
    var SchoolId: Int
    var FileUrlByteString: String
}
extension SchoolManager {
    // MARK: InsertSocialMultiMedia
    func insertSocialMultiMedia(data: InsertSocialMultiMedia, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.insertSocialMultiMedia(cred: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) {userResponse, error in
            if let error = error {
                print("DEBUG PRINT:", error);
                completion(false)
                return }
            print("DEBUG PRINT:", userResponse ?? "")
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                completion(false)
                return }
            completion(true)
        }
    }
}

//case deleteSocialMultiMediaLink(cred: Codable)
extension SchoolManager {
    // MARK: deleteSocialMultiMediaLink
    func deleteSocialMultiMediaLink(data: DeleteById, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.deleteSocialMultiMediaLink(cred: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) {userResponse, error in
            if error != nil {
                completion(false)
                return }
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                completion(false)
                return }
            completion(true)
        }
    }
}

//case insertDisabilityStatus(cred: InsertDisabilityStatus)
struct InsertDisabilityStatus: Codable {
    let DisabilityStatusId: Int
    let UserId: Int
}
extension SchoolManager {
    // MARK: Insert Disability Status
    func insertDisabilityStatus(data:InsertDisabilityStatus, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.insertDisabilityStatus(cred: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) {userResponse, error in
            if let error = error {
                print("DEBUG PRINT:", error);
                completion(false)
                return }
            print("DEBUG PRINT:", userResponse ?? "")
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                completion(false)
                return }
            completion(true)
        }
    }
}

//case deleteDisabilityStatus(cred: Codable)
extension SchoolManager {
    // MARK: deleteSocialMediaLink
    func deleteDisabilityStatus(data: DeleteById, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.deleteDisabilityStatus(cred: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) {userResponse, error in
            if error != nil {
                completion(false)
                return }
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                completion(false)
                return }
            completion(true)
        }
    }
}

//case studentAdmissionUpdate
struct StudentAdmissionUpdateCred:Codable {
    let Id: Int?
    let AdmissionStatusId: Int?
    let Class: String?
    let Fees: String?
    let Reason: String?
    let SlipByte: String?
    let SlipName: String?
}
extension SchoolManager {
    // MARK: studentAdmissionUpdate
    func studentAdmissionUpdate(data: StudentAdmissionUpdateCred, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.studentAdmissionUpdate(cred: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) {userResponse, error in
            if error != nil {
                completion(false)
                return }
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                completion(false)
                return }
            completion(true)
        }
    }
}
