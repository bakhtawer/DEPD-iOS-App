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
    
    var dataProds = [InstituteModel]()
    
    weak var delegate: (UserHomeVM)?
    
    init() {
        print("UserHomeViewModel- init")
    }
    
    deinit {
        print("UserHomeViewModel- deinit")
    }
    
    
    func fetchInstitutes() {
        
        delegate?.showLoader()
        
        dataProds = [InstituteModel(), InstituteModel(), InstituteModel(),InstituteModel(), InstituteModel(), InstituteModel(), InstituteModel(), InstituteModel(), InstituteModel(),InstituteModel(), InstituteModel(), InstituteModel(),InstituteModel(), InstituteModel(), InstituteModel(), InstituteModel(), InstituteModel(), InstituteModel()]
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5, execute: {[weak self] in
            self?.delegate?.hideLoader()
            self?.delegate?.fetchedInstitutes()
        })
    }
    
    func getCount() -> Int { dataProds.count }
}
