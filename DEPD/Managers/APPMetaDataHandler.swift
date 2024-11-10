//
//  APPMetaDataHandler.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 25/08/2024.
//

import Foundation

public enum UserType: Int {
    case Student = 1
    case School = 2
    case JobSeeker = 3
    case Employer = 4
    
    case StudentGuest = 5
}

final class APPMetaDataHandler {
    static let shared = APPMetaDataHandler()
    private init() {}
    
    private let service = APIService()
    
    var userType: UserType = UserType.Student
    
    // MARK: District
    func getDistricts() -> [District] {
        dataAllGeneralList?.DistrictList ?? []
    }
    func getDistrictsNames() -> [String] {
        (dataAllGeneralList?.DistrictList ?? []).map {$0.name ?? ""}
    }
    
    // MARK: Disability
    func getDisabilities() -> [Disability] {
        dataAllGeneralList?.DisabilityList ?? []
    }
    func getDisabilitiesNames() -> [String] {
        (dataAllGeneralList?.DisabilityList ?? []).map {$0.name ?? ""}
    }
    func getDisabilities(byID: Int) -> Disability? {
        (dataAllGeneralList?.DisabilityList ?? []).filter {$0.disabilityId == byID}.last ?? nil
    }
    
    // MARK: Gender
    func getGenders() -> [Gender] {
        dataAllGeneralList?.GenderList ?? []
    }
    
    // MARK: Designation
    func getDesignations() -> [String] {
        (dataAllGeneralList?.DesignationList ?? []).map {$0.name ?? ""}
    }
    
    // MARK: Previous Education
    func getPreviousEducation() -> [Degree] {
        dataAllGeneralList?.DegreeProgram ?? []
    }
    func getPreviousEducationName() -> [String] {
        (dataAllGeneralList?.DegreeProgram ?? []).map {$0.name ?? ""}
    }
    
    // MARK: Classes
    func getPreviousClasses() -> [Classes] {
        dataAllGeneralList?.classList ?? []
    }
    func getClassesName() -> [String] {
        (dataAllGeneralList?.classList ?? []).map {$0.name ?? ""}
    }
    
    
    // MARK: All General List
    private var dataAllGeneralList: AllGeneralList?
    func populateAllGeneralList(){
        let request = Endpoint.allGeneralList.request!
        service.makeRequest(with: request, respModel: AllGeneralList.self) {[weak self] userResponse, error in
            if let error = error { print("DEBUG PRINT:", error); return }
            print("DEBUG PRINT:", userResponse ?? "")
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong"); return }
            guard let allGeneralList = userResponse else { SMM.shared.showError(title: "", message: "Error parsing server response.");  return}
            self?.dataAllGeneralList = allGeneralList
        }
    }
}
