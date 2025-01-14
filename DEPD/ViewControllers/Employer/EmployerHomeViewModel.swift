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
    var employees: CompanyEmployeeModel?
    var jobApplications: CompanyJobModel?
    var advertise: CompanyVacancyModel?
}

protocol EmployerHomeVM: AnyObject {
    func showLoader()
    func hideLoader()
    
    func fetchedDetails()
}

class EmployerHomeViewModel {
    
    private var dataProds = [EmployerHomeViewModelData]()
    
    private var dataJobApplications = [EmployerHomeViewModelData]()
    private var dataFindEmployees = [EmployerHomeViewModelData]()
    private var dataVacancies = [EmployerHomeViewModelData]()
    
    weak var delegate: (EmployerHomeVM)?
    
    private let service = APIService()
    
    private var searchText: String?
    
    private var selectedStatusID: Int?
    
    init() {
        print("EmployerHomeViewModel- init")
    }
    
    deinit {
        print("EmployerHomeViewModel- deinit")
    }
    
    
    func getVacancy() {
        delegate?.showLoader()
        CompanyManager.shared.getVacancy {[weak self] data in
            self?.delegate?.hideLoader()
            self?.dataVacancies.removeAll()
            data?.forEach {
                self?.dataVacancies.append(EmployerHomeViewModelData(advertise: $0))
            }
            self?.delegate?.fetchedDetails()
        }
    }
    func getAdvertise() -> [EmployerHomeViewModelData] {
        var jobs = dataVacancies
        guard var searchText = searchText, !searchText.isEmpty else { return jobs }
        searchText = searchText.lowercased()
        jobs = jobs.filter { job in
            return (job.advertise?.CompanyName?.lowercased().contains(searchText) ?? false) ||
            (job.advertise?.Position?.lowercased().contains(searchText) ?? false)
        }
        return jobs
    }
    
    func resetAll() {
        delegate?.fetchedDetails()
    }
    
    func search(text: String?) {
        searchText = text
        delegate?.fetchedDetails()
    }
    
    func getTotaljobApplications() {
        delegate?.showLoader()
        CompanyManager.shared.getTotaljobApplications {[weak self] data in
            self?.delegate?.hideLoader()
            self?.dataJobApplications.removeAll()
            data?.forEach {
                self?.dataJobApplications.append(EmployerHomeViewModelData(jobApplications: $0))
            }
            self?.delegate?.fetchedDetails()
        }
    }
    func getHiredPerson() {
        delegate?.showLoader()
        CompanyManager.shared.getHiredPerson {[weak self] data in
            self?.delegate?.hideLoader()
            self?.dataJobApplications.removeAll()
            data?.forEach {
                self?.dataJobApplications.append(EmployerHomeViewModelData(jobApplications: $0))
            }
            self?.delegate?.fetchedDetails()
        }
    }

    
    func selectedStatus(status: Int) {
        self.selectedStatusID = status
        self.delegate?.fetchedDetails()
    }
    func getJobApplications() -> [EmployerHomeViewModelData] {
        var data = dataJobApplications
        if let status = selectedStatusID {
            data = data.filter {$0.jobApplications?.StatusId == status}
        }
        guard var searchText = searchText, !searchText.isEmpty else { return data }
        searchText = searchText.lowercased()
        data = data.filter { all in
            return (all.jobApplications?.FirstName?.lowercased().contains(searchText) ?? false) ||
            (all.jobApplications?.LastName?.lowercased().contains(searchText) ?? false) ||
            (all.jobApplications?.Address?.lowercased().contains(searchText) ?? false) ||
            (all.jobApplications?.dob?.lowercased().contains(searchText) ?? false) ||
            (all.jobApplications?.StatusName?.lowercased().contains(searchText) ?? false) ||
            (all.jobApplications?.ContactNo?.lowercased().contains(searchText) ?? false)
        }
        return data
    }
    
    
    // FIND EMPLOYEES
    var appliedFilters: [String : Any] = [:]
    func setAppliedFilters(filters: [String : Any]) {
        appliedFilters = filters
        var jobFilter = JobSeekerFilterCreds()
        
        if let gender = appliedFilters["gender"] as? String,
           let genID = AMDH.shared.getGenders(byName: gender)?.genderId {
            jobFilter.genderID = genID
        }
        
        if let district = appliedFilters["district"] as? String {
            jobFilter.districtText = district
        }
        
        if let disability = appliedFilters["disability"] as? String,
           let disID = AMDH.shared.getDisabilities(byName: disability)?.disabilityId {
            jobFilter.disabilityStatusID = disID
        }
        if let education = appliedFilters["education"] as? String,
           let disID = AMDH.shared.getPreviousEducationName(byName: education)?.mId {
            jobFilter.educationID = disID
        }
        
        getJobSeekerFilter(data: jobFilter)
    }
    func getFindEmployee() -> [EmployerHomeViewModelData] {
        var data = dataFindEmployees
        guard var searchText = searchText, !searchText.isEmpty else { return data }
        searchText = searchText.lowercased()
        data = data.filter { all in
            return (all.employees?.Address?.lowercased().contains(searchText) ?? false) ||
            (all.employees?.Name?.lowercased().contains(searchText) ?? false) ||
            (all.employees?.DisabilityName?.lowercased().contains(searchText) ?? false) ||
            (all.employees?.Address?.lowercased().contains(searchText) ?? false) ||
            (all.employees?.EmailAddress?.lowercased().contains(searchText) ?? false)
        }
        return data
    }
    func getJobSeekerFilter(data: JobSeekerFilterCreds) {
        delegate?.showLoader()
        CompanyManager.shared.getJobSeekerFilter(data: data) {[weak self] data in
            self?.delegate?.hideLoader()
            self?.dataFindEmployees.removeAll()
            data?.forEach {
                self?.dataFindEmployees.append(EmployerHomeViewModelData(employees: $0))
            }
            self?.delegate?.fetchedDetails()
        }
    }
}
