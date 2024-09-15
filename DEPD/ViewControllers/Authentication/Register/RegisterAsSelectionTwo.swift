//
//  RegisterAsSelectionTwo.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 09/06/2024.
//

import UIKit

class RegisterAsSelectionTwo: BaseViewController {
    
    var screenType: LoginScreenType = .student
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        labelTitle.makeItTheme(.regular)
        
        buttonOne.makeItThemeLargeTransBlack()
        buttonTwo.makeItThemeLargeTransBlack()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.isHidden = false
        
        labelTitle.text = "i_am".localized()
        
        switch screenType {
        case .student, .institute:
            setUpForStudent()
        case .jobSeeker, .companyHiring:
            setUpForJob()
        }
    }
    
    private func setUpForStudent() {
        buttonOne.setTitle("register_student".localized(), for: .normal)
        buttonTwo.setTitle("register_institute".localized(), for: .normal)
        
        buttonOne.addTapGestureRecognizer {[weak self] in
            self?.goForward()
            guard let self = self else {return}
            self.screenType = .student
            self.goForward()
        }
        buttonTwo.addTapGestureRecognizer {[weak self] in
            self?.goForward()
            guard let self = self else {return}
            self.screenType = .institute
            self.goForward()
        }
    }
    
    private func setUpForJob() {
        buttonOne.setTitle("job_seeker".localized(), for: .normal)
        buttonTwo.setTitle("company_hiring".localized(), for: .normal)
        
        buttonOne.addTapGestureRecognizer {[weak self] in
            guard let self = self else {return}
            self.screenType = .jobSeeker
            self.goForward()
        }
        buttonTwo.addTapGestureRecognizer {[weak self] in
            guard let self = self else {return}
            self.screenType = .companyHiring
            self.goForward()
        }
    }
    
    private func goForward() {
        switch screenType {
        case .student:
            Bootstrapper.createLogin(screenType: .student)
        case .jobSeeker:
            Bootstrapper.createLogin(screenType: .jobSeeker)
        case .companyHiring:
            Bootstrapper.createLogin(screenType: .companyHiring)
        case .institute:
            Bootstrapper.createLogin(screenType: .institute)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigation()
    }
}
extension RegisterAsSelectionTwo {
    
    func setupNavigation() {
        self.setLogo()
        self.setBackButton(.appBackButton).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
