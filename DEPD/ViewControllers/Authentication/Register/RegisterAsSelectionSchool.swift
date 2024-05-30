//
//  RegisterAsSelectionSchool.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 27/05/2024.
//

import UIKit

class RegisterAsSelectionSchool: BaseViewController {
    
    @IBOutlet weak var buttonInclusiveEducation: UIButton!
    @IBOutlet weak var buttonInclusiveCareer: UIButton!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        buttonInclusiveEducation.makeItThemeLargeWhite(24, .appBlue)
        buttonInclusiveCareer.makeItThemeLargeWhite(24, .appBlue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        self.navigationController?.navigationBar.isHidden = false
        
        buttonInclusiveEducation.setTitle("register_student".localized(), for: .normal)
        buttonInclusiveCareer.setTitle("register_institute".localized(), for: .normal)
        
        buttonInclusiveEducation.addTapGestureRecognizer {
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: RegisterViewController.self)
            openModuleOnNavigation(from: self, controller: view)
        }
        buttonInclusiveCareer.addTapGestureRecognizer {
            SMM.shared.showStatusInfo(message: "Coming Soon")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigation()
    }
}
extension RegisterAsSelectionSchool {
    
    func setupNavigation() {
        self.setTitle("Register")
        self.setNavBarColor(.appBlue)
        self.setBackButton(.appLight).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
