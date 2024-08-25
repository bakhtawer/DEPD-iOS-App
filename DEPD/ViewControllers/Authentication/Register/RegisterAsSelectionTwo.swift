//
//  RegisterAsSelectionTwo.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 09/06/2024.
//

import UIKit

class RegisterAsSelectionTwo: BaseViewController {
    
    enum ScreenType {
        case student
        case job
    }
    
    var screenType: ScreenType = .student
    
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
        self.navigationController?.navigationBar.isHidden = false
        
        labelTitle.text = "i_am".localized()
        
        switch screenType {
        case .student:
            setUpForStudent()
        case .job:
            setUpForJob()
        }
    }
    
    private func setUpForStudent() {
        buttonOne.setTitle("register_student".localized(), for: .normal)
        buttonTwo.setTitle("register_institute".localized(), for: .normal)
        
        buttonOne.addTapGestureRecognizer {[weak self] in
            self?.goForward()
        }
        buttonTwo.addTapGestureRecognizer {[weak self] in
            self?.goForward()
        }
    }
    
    private func setUpForJob() {
        buttonOne.setTitle("student".localized(), for: .normal)
        buttonTwo.setTitle("job_seeker".localized(), for: .normal)
        
        buttonOne.addTapGestureRecognizer {[weak self] in
            self?.goForward()
        }
        buttonTwo.addTapGestureRecognizer {[weak self] in
            self?.goForward()
        }
    }
    
    private func goForward() {
        switch screenType {
        case .student:
            Bootstrapper.createLogin(screenType: .student)
        case .job:
            Bootstrapper.createLogin(screenType: .jobSeeker)
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
