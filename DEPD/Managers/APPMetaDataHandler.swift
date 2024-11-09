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
    private var districts = [District]()
    func populateDistricts(){
        let request = Endpoint.getDistrict.request!
        service.makeRequest(with: request, respModel: ApiResponse<[District]>.self) {[weak self] userResponse, error in
            if let error = error { print("DEBUG PRINT:", error); return }
            print("DEBUG PRINT:", userResponse ?? "")
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong"); return }
            guard let districts = userResponse?.oData else { SMM.shared.showError(title: "", message: "Error parsing server response.");  return}
            self?.districts = districts
        }
    }
    func getDistricts() -> [District] {
        districts
    }
    func getDistrictsNames() -> [String] {
        districts.map {$0.name ?? ""}
    }
    
    // MARK: Disability
    private var disabilities = [Disability]()
    func populateDisabilities(){
        let request = Endpoint.getDisstatList.request!
        
        service.makeRequest(with: request, respModel: ApiResponse<[Disability]>.self) {[weak self] userResponse, error in
            if let error = error { print("DEBUG PRINT:", error); return }
            print("DEBUG PRINT:", userResponse ?? "")
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong"); return }
            guard let districts = userResponse?.oData else { SMM.shared.showError(title: "", message: "Error parsing server response.");  return}
            self?.disabilities = districts
        }
    }
    func getDisabilities() -> [Disability] {
        disabilities
    }
    func getDisabilitiesNames() -> [String] {
        disabilities.map {$0.name ?? ""}
    }
    
    // MARK: Gender
    private var genders = [Gender]()
    func populateGenders(){
        let request = Endpoint.getGenders.request!
        
        service.makeRequest(with: request, respModel: ApiResponse<[Gender]>.self) {[weak self] userResponse, error in
            if let error = error { print("DEBUG PRINT:", error); return }
            print("DEBUG PRINT:", userResponse ?? "")
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong"); return }
            guard let genders = userResponse?.oData else { SMM.shared.showError(title: "", message: "Error parsing server response.");  return}
            self?.genders = genders
        }
    }
    func getGenders() -> [Gender] {
        genders
    }
    
    // MARK: Gender
    private var designations = [Designations]()
    func populateDesignations(){
        let request = Endpoint.getDesignations.request!
        service.makeRequest(with: request, respModel: ApiResponse<[Designations]>.self) {[weak self] userResponse, error in
            if let error = error { print("DEBUG PRINT:", error); return }
            print("DEBUG PRINT:", userResponse ?? "")
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong"); return }
            guard let designations = userResponse?.oData else { SMM.shared.showError(title: "", message: "Error parsing server response.");  return}
            self?.designations = designations
        }
    }
    func getDesignations() -> [String] {
        designations.map {$0.name ?? ""}
    }
    
    // MARK: Previous Education
    private var previousEducation = [PreviousEducation]()
    func populatePreviousEducation(){
        let request = Endpoint.getPreviousEducation.request!
        service.makeRequest(with: request, respModel: ApiResponse<[PreviousEducation]>.self) {[weak self] userResponse, error in
            if let error = error { print("DEBUG PRINT:", error); return }
            print("DEBUG PRINT:", userResponse ?? "")
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong"); return }
            guard let previousEducation = userResponse?.oData else { SMM.shared.showError(title: "", message: "Error parsing server response.");  return}
            self?.previousEducation = previousEducation
        }
    }
    func getPreviousEducation() -> [PreviousEducation] {
        previousEducation
    }
    func getPreviousEducationName() -> [String] {
        previousEducation.map {$0.name ?? ""}
    }
    
    // MARK: Classes
    private var classes = [Classes]()
    func populateClasses(){
        let request = Endpoint.getClasses.request!
        service.makeRequest(with: request, respModel: ApiResponse<[Classes]>.self) {[weak self] userResponse, error in
            if let error = error { print("DEBUG PRINT:", error); return }
            print("DEBUG PRINT:", userResponse ?? "")
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong"); return }
            guard let previousEducation = userResponse?.oData else { SMM.shared.showError(title: "", message: "Error parsing server response.");  return}
            self?.classes = previousEducation
        }
    }
    func getPreviousClasses() -> [Classes] {
        classes
    }
    func getClassesName() -> [String] {
        classes.map {$0.name ?? ""}
    }
}
