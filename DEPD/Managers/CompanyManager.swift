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
    let disabilityStatusID: Int?
    let districtText: Int?
    let educationID: Int?
    let genderID: Int?
    init(disabilityStatusID: Int? = nil,
         districtText: Int? = nil,
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
    
    private enum companyMethods: String {
        case totalJobApplications, hiredPerson, JobSeekerFilter, Vacancy
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
