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
    case JobSeekerGuest = 6
}
typealias AMDH = APPMetaDataHandler
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
    func getDistrictsNames(byName: String) -> District? {
        (dataAllGeneralList?.DistrictList ?? []).filter {$0.name == byName}.last ?? nil
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
    
    func getDisabilities(byName: String) -> Disability? {
        let filteredList = (dataAllGeneralList?.DisabilityList ?? []).filter {
            // Normalize and trim both the name and search string
            let trimmedName = $0.name?.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\r\n", with: " ").replacingOccurrences(of: "\n", with: " ") ?? ""
            let trimmedSearchTerm = byName.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\r\n", with: " ").replacingOccurrences(of: "\n", with: " ")
            return trimmedName.contains(trimmedSearchTerm)
        }
        return filteredList.first
    }
    
    // MARK: Gender
    func getGenders() -> [Gender] {
        dataAllGeneralList?.GenderList ?? []
    }
    func getGenders(byID: Int) -> Gender? {
        (dataAllGeneralList?.GenderList ?? []).filter {$0.genderId == byID}.last ?? nil
    }
    func getGenders(byName: String) -> Gender? {
        (dataAllGeneralList?.GenderList ?? []).filter {$0.name == byName}.last ?? nil
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
    func getPreviousEducationName(byName: String) -> Degree? {
        (dataAllGeneralList?.DegreeProgram ?? []).filter {$0.name == byName}.last ?? nil
    }
    
    // MARK: Classes
    func getPreviousClasses() -> [Classes] {
        dataAllGeneralList?.classList ?? []
    }
    func getClassesName() -> [String] {
        (dataAllGeneralList?.classList ?? []).map {$0.name ?? ""}
    }
    
    // MARK: Genders
    func getGendersName() -> [String] {
        (dataAllGeneralList?.GenderList ?? []).map {$0.name ?? ""}
    }
    
    // MARK: Languages
    func getLanguagesName() -> [String] {
        (dataAllGeneralList?.languageList ?? []).map {$0.name ?? ""}
    }
    
    // MARK: Languages
    func getTechnicalSkillListName() -> [String] {
        (dataAllGeneralList?.TechnicalSkillList ?? []).map {$0.name ?? ""}
    }
    
    // MARK: SocialMediaList
    func getSocialMediaListName() -> [String] {
        (dataAllGeneralList?.socialMediaList ?? []).map {$0.link ?? ""}
    }
    func getSocialMediaList(byName: String) -> SocialMediaList? {
        (dataAllGeneralList?.socialMediaList ?? []).filter {$0.link == byName}.last ?? nil
    }
    
//    // MARK: District
//    func getDistricts() -> [District] {
//        dataAllGeneralList?.DistrictList ?? []
//    }
//    func getDistrictsNames() -> [String] {
//        (dataAllGeneralList?.DistrictList ?? []).map {$0.name ?? ""}
//    }
//    func getDistrictsNames(byName: String) -> District? {
//        (dataAllGeneralList?.DistrictList ?? []).filter {$0.name == byName}.last ?? nil
//    }
    
    
    // MARK: accessibilityList
    func getAccessibilityListName() -> [String] {
        (dataAllGeneralList?.accessibilityList ?? []).map {$0.name ?? ""}
    }
    func getAccessibilityListName(byName: String) -> AllListData? {
        (dataAllGeneralList?.accessibilityList ?? []).filter {$0.name == byName}.last ?? nil
    }
    
    // MARK: All General List
    private var dataAllGeneralList: AllGeneralList?
    func populateAllGeneralList(){
        let request = Endpoint.allGeneralList.request!
        service.makeRequest(with: request, respModel: AllGeneralList.self) {[weak self] userResponse, error in
            if let error = error { print("DEBUG PRINT:", error); return }
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong"); return }
            guard let allGeneralList = userResponse else { SMM.shared.showError(title: "", message: "Error parsing server response.");  return}
            self?.dataAllGeneralList = allGeneralList
        }
    }
    
    func getYesNoFromInt(value: Int) -> String {
        return value == 1 ? "YES" : "NO"
    }
    
    func getFreePaidFromInt(value: Int) -> String {
        return value == 2 ? "Paid" : "Free"
    }
    
    func getAdmissionStatus(value: Int) -> String {
        switch value {
        case 1: return "pending".localized()
        case 2: return "accepted".localized()
        case 3: return "rejected".localized()
        default: return ""
        }
    }
}
