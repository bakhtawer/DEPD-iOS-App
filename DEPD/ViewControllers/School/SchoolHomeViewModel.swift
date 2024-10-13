//
//  SchoolHomeViewModel.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 14/09/2024.
//

import Foundation

protocol SchoolHomeVM: AnyObject {
    func showLoader()
    func hideLoader()
    
    func fetchedInstitutes()
    func fetchedInstituteDetails()
}

class SchoolHomeViewModel {
    
    private var dataProds = [InstituteHomeModel]()
    
    weak var delegate: (SchoolHomeVM)?
    
    private let service = APIService()
    
    private var searchText: String?
    private var schoolID: Int
    
    var selectedSchool: InstituteModel?
    
    init() {
        print("SchoolHomeViewModel- init")
        self.schoolID = -1
        APPMetaDataHandler.shared.populateDesignations()
        guard let schoolID = USM.shared.getUser().userId, schoolID != -1 else { return }
        self.schoolID = schoolID
        fetchALlSchoolsForDetailsStudents()
    }
    
    deinit {
        print("SchoolHomeViewModel- deinit")
    }
    
    func fetchALlSchoolsForDetailsStudents() {
        delegate?.showLoader()
        let request = Endpoint.getSchoolList.request!
        service.makeRequest(with: request, respModel: ApiResponse<[InstituteModel]>.self) {[weak self] userResponse, error in
            if let error = error { print("DEBUG PRINT:", error); return }
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong"); return }
            guard let schools = userResponse?.oData else { SMM.shared.showError(title: "", message: "Error parsing server response.");  return}
            self?.selectedSchool = schools.filter { $0.InstituteId == self?.schoolID }.last
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {[weak self] in
                self?.delegate?.hideLoader()
                self?.delegate?.fetchedInstituteDetails()
            })
        }
    }
    
    
    func fetchStudents() {
        delegate?.showLoader()
        let request = Endpoint.getStudentAdmissions(schoolID: schoolID).request!
        service.makeRequest(with: request, respModel: ApiResponse<[InstituteHomeModel]>.self) {[weak self] userResponse, error in
            if let error = error { print("DEBUG PRINT:", error); return }
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong"); return }
            guard let schools = userResponse?.oData else { SMM.shared.showError(title: "", message: "Error parsing server response.");  return}
            self?.dataProds = schools
            print(schools.count)
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {[weak self] in
                self?.delegate?.hideLoader()
                self?.delegate?.fetchedInstitutes()
            })
        }
    }
    
    func getCount() -> Int { dataProds.count }
    
    func getInstitutes() -> [InstituteHomeModel] {
        var students = dataProds
        // Check if search text is provided
        guard var searchText = searchText, !searchText.isEmpty else { return dataProds }
        searchText = searchText.lowercased()
        // Filter based on student properties as well as Gender and District
        students = students.filter { institute in
            if let student = institute.student {
                return (student.FirstName?.lowercased().contains(searchText) ?? false) ||
                       (student.LastName?.lowercased().contains(searchText) ?? false) ||
                       (student.CNIC?.lowercased().contains(searchText) ?? false) ||
                       (institute.Gender?.lowercased().contains(searchText) ?? false) ||
                       (institute.District?.lowercased().contains(searchText) ?? false)
            }
            return false
        }
        return students
    }
    
    func resetAll() {
        delegate?.fetchedInstitutes()
    }
    
    
    func search(text: String?) {
        searchText = text
        delegate?.fetchedInstitutes()
    }
}
