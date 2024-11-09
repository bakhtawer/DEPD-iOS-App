//
//  InclusiveScreenThreeButtons.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 01/11/2024.
//

import UIKit

class InclusiveScreenThreeButtons: BaseViewController {
    
    var screenType: LoginScreenType = .student
    
    @IBOutlet weak var viewButtonOne: UIView!
    @IBOutlet weak var iconButtonOne: UIImageView!
    @IBOutlet weak var labelButtonOne: UILabel!
    
    @IBOutlet weak var viewButtonTwo: UIView!
    @IBOutlet weak var iconButtonTwo: UIImageView!
    @IBOutlet weak var labelButtonTwo: UILabel!
    
    @IBOutlet weak var viewButtonThree: UIView!
    @IBOutlet weak var iconButtonThree: UIImageView!
    @IBOutlet weak var labelButtonThree: UILabel!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        self.navigationController?.navigationBar.isHidden = false
        setView()
        
        APPMetaDataHandler.shared.populateDistricts()
        APPMetaDataHandler.shared.populateDisabilities()
        
        viewButtonOne.addTapGestureRecognizer {[weak self] in
            if self?.screenType == .student {
                Bootstrapper.createLogin(screenType: .student)
            } else {
                Bootstrapper.createLogin(screenType: .jobSeeker)
            }
        }
        
        viewButtonTwo.addTapGestureRecognizer {[weak self] in
            if self?.screenType == .student {
                DispatchQueue.main.async {[weak self] in
                    let storyboard = getStoryBoard(.main)
                    let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                    view.type = .denialOfAdmission
                    openModuleOnNavigation(from: self, controller: view)
                }
            } else {
                DispatchQueue.main.async {[weak self] in
                    let storyboard = getStoryBoard(.main)
                    let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                    view.type = .denialOfJob
                    openModuleOnNavigation(from: self, controller: view)
                }
            }
        }
        
        viewButtonThree.addTapGestureRecognizer {[weak self] in
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: GenericFormBuilderViewController.self)
            view.screenType = .complain
            openModuleOnNavigation(from: self, controller: view)
        }
    }
    
    private func setView() {
        if screenType == .student {
            
            viewButtonOne.applyShadow()
            iconButtonOne.image = UIImage(named: "admission_one")
            labelButtonOne.text = "admissions".localized()
            viewButtonTwo.applyShadow()
            iconButtonTwo.image = UIImage(named: "admission")
            labelButtonTwo.text = "complain_for_denial_of_admission".localized()
            viewButtonThree.applyShadow()
            iconButtonThree.image = UIImage(named: "complaint")
            labelButtonThree.text = "register_complain".localized()
            
        }else  {
            viewButtonOne.applyShadow()
            iconButtonOne.image = UIImage(named: "find_job")
            labelButtonOne.text = "find_a_job".localized()
            viewButtonTwo.applyShadow()
            iconButtonTwo.image = UIImage(named: "find_job")
            labelButtonTwo.text = "complain_for_denial_of_job".localized()
            viewButtonThree.applyShadow()
            iconButtonThree.image = UIImage(named: "complaint")
            labelButtonThree.text = "register_complain".localized()
        }
        
        labelButtonOne.makeItTheme(.bold, 24, .textLight, .center)
        labelButtonTwo.makeItTheme(.bold, 24, .textLight, .center)
        labelButtonThree.makeItTheme(.bold, 24, .textLight, .center)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigation()
    }
}
extension InclusiveScreenThreeButtons {
    
    func setupNavigation() {
        self.setLogo()
        self.setBackButton(.appBackButton).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
