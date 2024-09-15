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
    func getDesignations() -> [Designations] {
        designations
    }
    
}
