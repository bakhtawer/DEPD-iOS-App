//
//  JobSeekerHomeViewModel.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 26/10/2024.
//

import UIKit

protocol JobSeekerVM: AnyObject {
    func showLoader()
    func hideLoader()
    
    func fetchedJobs()
}

class JobSeekerHomeViewModel {
    
    private var dataProds = [CompanyModel]()
    
    weak var delegate: (JobSeekerVM)?
    
    private let service = APIService()
    
    private var searchText: String?
    private var schoolID: Int
    
    init() {
        print("JobSeekerHomeViewModel- init")
        self.schoolID = -1
    }
    
    deinit {
        print("JobSeekerHomeViewModel- deinit")
    }
    
    func fetchAllJobs() {
        delegate?.showLoader()
        let request = Endpoint.getJobList.request!
        service.makeRequest(with: request, respModel: ApiResponse<[CompanyModel]>.self) {[weak self] userResponse, error in
            if let error = error { print("DEBUG PRINT:", error); return }
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong"); return }
            guard let jobs = userResponse?.oData else { SMM.shared.showError(title: "", message: "Error parsing server response.");  return}
            self?.dataProds = jobs
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {[weak self] in
                self?.delegate?.hideLoader()
                self?.delegate?.fetchedJobs()
            })
        }
    }

    func getCount() -> Int { dataProds.count }
    
    func getJobs() -> [CompanyModel] {
        var jobs = dataProds
//        // Check if search text is provided
        guard var searchText = searchText, !searchText.isEmpty else { return dataProds }
        searchText = searchText.lowercased()
        jobs = jobs.filter { job in
            return (job.CompanyName?.lowercased().contains(searchText) ?? false) ||
                   (job.PositionName?.lowercased().contains(searchText) ?? false)
        }
        return jobs
    }
    
    func resetAll() {
        delegate?.fetchedJobs()
    }
    
    
    func search(text: String?) {
        searchText = text
        delegate?.fetchedJobs()
    }
}
