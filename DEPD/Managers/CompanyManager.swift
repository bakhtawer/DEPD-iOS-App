//
//  CompanyManager.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 30/12/2024.
//

struct CompanyById: Codable {
    var Id: Int?
    var UserID: Int?
    var CompanyID: Int?
}

struct JobSeekerFilterCreds: Codable {
    var disabilityStatusID: Int?
    var districtText: String?
    var educationID: Int?
    var genderID: Int?
    init(disabilityStatusID: Int? = nil,
         districtText: String? = nil,
         educationID: Int? = nil,
         genderID: Int? = nil) {
        self.disabilityStatusID = disabilityStatusID
        self.districtText = districtText
        self.educationID = educationID
        self.genderID = genderID
    }
}

final class CompanyManager {
    static let shared = CompanyManager()
    private let service = APIService()
    private init() {}
    
    private let companyProfileID = CompanyById(Id: USM.shared.getUser().id!)
    private let companyUserID = CompanyById(UserID: USM.shared.getUser().id!)
    private let companyID = CompanyById(CompanyID: USM.shared.getUser().id!)
    
    enum companyMethods: String {
        case totalJobApplications, hiredPerson, JobSeekerFilter, Vacancy,
             InsertAccebilityMaterial, InsertSchoolAndCompanyDisability, InsertSocialMedia,
             DeleteAccebilityMaterial, DeleteWeCanEducate, DeleteSocialMedia,
             updateCompany, uploadCompanyProfileImage, updateApplicationStatus
    }
    
    func getTotaljobApplications(completion: @escaping ([CompanyJobModel]?) -> Void) {
        let request = Endpoint.company(id: companyProfileID,
                                       method: companyMethods.totalJobApplications.rawValue).request!
        service.makeRequest(with: request, respModel: ApiResponse<[CompanyJobModel]>.self) { [weak self] userResponse, error in
            self?.handelResponse(error, userResponse) {status in completion(status)}
        }
    }
    
    func getHiredPerson(completion: @escaping ([CompanyJobModel]?) -> Void) {
        let request = Endpoint.company(id: companyUserID,
                                       method: companyMethods.hiredPerson.rawValue).request!
        service.makeRequest(with: request, respModel: ApiResponse<[CompanyJobModel]>.self) { [weak self] userResponse, error in
            self?.handelResponse(error, userResponse) {status in completion(status)}
        }
    }
    
    func handelResponse(_ error: APIError?,
                        _ userResponse: ApiResponse<[CompanyJobModel]>?,
                        completion: @escaping ([CompanyJobModel]?) -> Void) {
        if error != nil {
            completion(nil)
            return }
        if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
            completion(nil)
            return }
        completion(userResponse?.oData)
    }
}

extension CompanyManager {
    func getVacancy(completion: @escaping ([CompanyVacancyModel]?) -> Void) {
        let request = Endpoint.company(id: companyID,
                                       method: companyMethods.Vacancy.rawValue).request!
        service.makeRequest(with: request, respModel: ApiResponse<[CompanyVacancyModel]>.self) { userResponse, error in
            if error != nil {
                completion(nil)
                return }
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                completion(nil)
                return }
            completion(userResponse?.oData)
        }
    }
}

extension CompanyManager {
    func getJobSeekerFilter(data: JobSeekerFilterCreds, completion: @escaping ([CompanyEmployeeModel]?) -> Void) {
        let request = Endpoint.company(id: companyProfileID,
                                       method: companyMethods.JobSeekerFilter.rawValue).request!
        service.makeRequest(with: request, respModel: ApiResponse<[CompanyEmployeeModel]>.self) { userResponse, error in
            if error != nil {
                completion(nil)
                return }
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
                completion(nil)
                return }
            completion(userResponse?.oData)
        }
    }
}


struct CompanyJobPostCreds: Codable {
    var companyId: Int
    var descriptionText: String
    var distict: Int
    var location: String
    var noOfVaccancies: Int
    var positionName: String
    var requiredExperience: Int
    var salary: Int
    var thumbnailImageName: String?
    var thumbnailImageNameByteString: String?
    init(companyId: Int, descriptionText: String, distict: Int, location: String, noOfVaccancies: Int, positionName: String, requiredExperience: Int, salary: Int,
         thumbnailImageName: String?,
         thumbnailImageNameByteString: String?) {
        self.companyId = companyId
        self.descriptionText = descriptionText
        self.distict = distict
        self.location = location
        self.noOfVaccancies = noOfVaccancies
        self.positionName = positionName
        self.requiredExperience = requiredExperience
        self.salary = salary
        self.thumbnailImageName = thumbnailImageName
        self.thumbnailImageNameByteString = thumbnailImageNameByteString
    }
}
extension CompanyManager {
    func postJob(data: CompanyJobPostCreds, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.company(id: companyProfileID,
                                       method: companyMethods.JobSeekerFilter.rawValue).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) { userResponse, error in
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

struct CompanyUpdateCreds: Codable {
    var MaterialID: Int?
    var MaterialName: String?
    var SchoolId: Int?
    
    
    var AccountTypeID: Int?
    var relID: Int?
    var SocialMediaLink: String?
    
    
    var disabilityStatusId: Int?
    var userId: Int?
    
    var UserId: Int?
    var Id: Int?
    
    var AvailableQuotaForPWDs: String?
    var cnic: String?
    var companyId: Int?
    var companyName: String?
    var ContactNumber: String?
    var Description: String?
    var Designation: String?
    var District: String?
    var EmailAdress: String?
    var FirstName: String?
    var id: Int?
    var LastName: String?
    var Location: String?
    var NTNNumber: String?
    var RegistirationNumber: String?
    var Website: String?
    
    var CompanyDetailId: Int?
    var ProfileImageName: String?
    var ProfilePictureBytesString: String?
    
    
    var Reason: String?
    var StatusId: Int?
    
    var DocumentBytesString: String?
}
extension CompanyManager {
    func updateCompany(data: CompanyUpdateCreds, method: companyMethods, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.companyUpdate(id: data,
                                       method: method.rawValue).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) { userResponse, error in
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
