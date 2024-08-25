//
//  RegisterAsSelectionOne.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 27/05/2024.
//

import UIKit

class RegisterAsSelectionOne: BaseViewController {
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var buttonInclusiveEducation: UIButton!
    @IBOutlet weak var buttonInclusiveCareer: UIButton!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        labelTitle.makeItTheme(.regular)
        
        buttonInclusiveEducation.makeItThemeLargeTransBlack()
        buttonInclusiveCareer.makeItThemeLargeTransBlack()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        self.navigationController?.navigationBar.isHidden = false
        
        labelTitle.text = "i_am_looking_for_a".localized()
        
        buttonInclusiveEducation.setTitle("register_institute_school".localized(), for: .normal)
        buttonInclusiveCareer.setTitle("register_company_hiring".localized(), for: .normal)
        
        buttonInclusiveEducation.addTapGestureRecognizer {
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: RegisterAsSelectionTwo.self)
            view.screenType = .student
            openModuleOnNavigation(from: self, controller: view)
        }
        buttonInclusiveCareer.addTapGestureRecognizer {
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: RegisterAsSelectionTwo.self)
            view.screenType = .job
            openModuleOnNavigation(from: self, controller: view)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigation()
    }
}
extension RegisterAsSelectionOne {
    
    func setupNavigation() {
        self.setLogo()
    }
}
