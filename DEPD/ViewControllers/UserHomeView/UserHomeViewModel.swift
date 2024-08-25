//
//  UserHomeViewModel.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 26/05/2024.
//

import Foundation

protocol UserHomeVM: AnyObject {
    func showLoader()
    func hideLoader()
    
    func fetchedInstitutes()
}

class UserHomeViewModel {
    
    private var dataProds = [InstituteModel]()
    
    weak var delegate: (UserHomeVM)?
    
    private let service = APIService()
    
    private var selectedDistrict: District? = nil
    private var selectedDisability: Disability? = nil
    
    init() {
        print("UserHomeViewModel- init")
        
        APPMetaDataHandler.shared.populateDistricts()
        APPMetaDataHandler.shared.populateDisabilities()
    }
    
    deinit {
        print("UserHomeViewModel- deinit")
    }
    
    
    func fetchInstitutes() {
        delegate?.showLoader()
        let request = Endpoint.getSchoolList.request!
        service.makeRequest(with: request, respModel: ApiResponse<[InstituteModel]>.self) {[weak self] userResponse, error in
            if let error = error { print("DEBUG PRINT:", error); return }
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong"); return }
            guard let schools = userResponse?.oData else { SMM.shared.showError(title: "", message: "Error parsing server response.");  return}
            self?.dataProds = schools
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {[weak self] in
                self?.delegate?.hideLoader()
                self?.delegate?.fetchedInstitutes()
            })
        }
    }
    
    func getCount() -> Int { dataProds.count }
    
    func getInstitutes() -> [InstituteModel] {
        var institutes = dataProds
        
        if let district = selectedDistrict {
            institutes = dataProds.filter { $0.Location == district.name }
        }
        
        if let disability = selectedDisability {
            institutes = dataProds.filter { $0.SchoolDisabilityList?.contains(where: {$0.schoolDisabilityId == disability.disabilityId }) ?? false }
        }
        
        return institutes
    }
    
    func setDistrict(district: District) {
        selectedDistrict = district
        delegate?.fetchedInstitutes()
    }
    func setDisability(disability: Disability) {
        selectedDisability = disability
        delegate?.fetchedInstitutes()
    }
    
    func getDistrictName() -> String {
        selectedDistrict?.name ?? "Select Location"
    }
    func getDisabilityName() -> String {
        selectedDisability?.name ?? "Select Disability"
    }
    
    func resetAll() {
        selectedDistrict = nil
        selectedDisability = nil
        delegate?.fetchedInstitutes()
    }
    
}
