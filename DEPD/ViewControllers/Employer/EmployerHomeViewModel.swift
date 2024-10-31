//
//  EmployerHomeViewModel.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 13/10/2024.
//

import Foundation


struct EmployerHomeViewModelData: Codable, Hashable {
    static func == (lhs: EmployerHomeViewModelData, rhs: EmployerHomeViewModelData) -> Bool {
        return rhs.id == lhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    var id = UUID()
    var employees: JobSeekerModel?
    var company: CompanyModel?
    var advertise: JobSeekerModel?
}

protocol EmployerHomeVM: AnyObject {
    func showLoader()
    func hideLoader()
    
    func fetchedDetails()
}

class EmployerHomeViewModel {
    
    private var dataProds = [EmployerHomeViewModelData]()
    
    private var dataEmployees = [EmployerHomeViewModelData]()
    
    weak var delegate: (EmployerHomeVM)?
    
    private let service = APIService()
    
    private var searchText: String?
    
    init() {
        print("EmployerHomeViewModel- init")
    }
    
    deinit {
        print("EmployerHomeViewModel- deinit")
    }
    
    func fetchAllJobs() {
        delegate?.showLoader()
        let request = Endpoint.getJobList.request!
        service.makeRequest(with: request, respModel: ApiResponse<[CompanyModel]>.self) {[weak self] userResponse, error in
            if let error = error { print("DEBUG PRINT:", error); return }
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong"); return }
            guard let jobs = userResponse?.oData else { SMM.shared.showError(title: "", message: "Error parsing server response.");  return}
            let data = jobs.map {
                EmployerHomeViewModelData(company: $0)
            }
            self?.dataProds = data
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {[weak self] in
                self?.delegate?.hideLoader()
                self?.delegate?.fetchedDetails()
            })
        }
    }

    func getCount() -> Int { dataProds.count }
    
    func getEmployees() -> [EmployerHomeViewModelData] {
        [EmployerHomeViewModelData(employees: JobSeekerModel()),
         EmployerHomeViewModelData(employees: JobSeekerModel()),
         EmployerHomeViewModelData(employees: JobSeekerModel())]
    }
    func getAdvertise() -> [EmployerHomeViewModelData] {
        [EmployerHomeViewModelData(advertise: JobSeekerModel()),
         EmployerHomeViewModelData(advertise: JobSeekerModel()),
         EmployerHomeViewModelData(advertise: JobSeekerModel())]
    }
    
    func getJobs() -> [EmployerHomeViewModelData] {
        var jobs = dataProds
//        // Check if search text is provided
//        guard var searchText = searchText, !searchText.isEmpty else { return dataProds }
//        searchText = searchText.lowercased()
//        // Filter based on student properties as well as Gender and District
//        jobs = jobs.filter { all in
//            return (all .CompanyName?.lowercased().contains(searchText) ?? false) ||
//            ($0.PositionName?.lowercased().contains(searchText) ?? false) ||
//            ($0.Salary?.lowercased().contains(searchText) ?? false) ||
//            ($0.DescriptionText?.lowercased().contains(searchText) ?? false) ||
//            ($0.Location?.lowercased().contains(searchText) ?? false)
//        }
        return jobs
    }
    
    func resetAll() {
        delegate?.fetchedDetails()
    }
    
    func search(text: String?) {
        searchText = text
        delegate?.fetchedDetails()
    }
}
