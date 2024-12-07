//
//  AppHomeViewContoller.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 30/11/2024.
//

import UIKit

class AppHomeViewContoller: BaseViewController {
    
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var textTopDescription: UILabel!
    @IBOutlet weak var viewBottom: BottomView!
    
    @IBOutlet weak var iconStudent: UIImageView!
    @IBOutlet weak var viewStudent: UIView!
    @IBOutlet weak var labelStudent: UILabel!
    
    @IBOutlet weak var iconJob: UIImageView!
    @IBOutlet weak var viewJob: UIView!
    @IBOutlet weak var labelJob: UILabel!
    
    
    @IBOutlet weak var iconEI: UIImageView!
    @IBOutlet weak var viewForEducationalInstitutes: UIView!
    @IBOutlet weak var labelEI: UILabel!
    
    @IBOutlet weak var iconEC: UIImageView!
    @IBOutlet weak var viewForEmployerCompanies: UIView!
    @IBOutlet weak var labelEC: UILabel!
    
    
    @IBOutlet weak var labelKnowYourRights: UILabel!
    @IBOutlet weak var viewKnowYourRights: UIView!
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        self.navigationController?.navigationBar.isHidden = true
        setView()
        
        viewStudent.addTapGestureRecognizer {
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: InclusiveScreenThreeButtons.self)
            view.screenType = .student
            openModuleOnNavigation(from: self, controller: view)
        }
        viewJob.addTapGestureRecognizer {
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: InclusiveScreenThreeButtons.self)
            view.screenType = .jobSeeker
            openModuleOnNavigation(from: self, controller: view)
        }
        viewForEducationalInstitutes.addTapGestureRecognizer {
            Bootstrapper.createLogin(screenType: .institute)
        }
        viewForEmployerCompanies.addTapGestureRecognizer {
            Bootstrapper.createLogin(screenType: .companyHiring)
        }
        viewKnowYourRights.addTapGestureRecognizer {}
        
    }
    
    private func setView() {
        textTopDescription.text = "SPDP".localized()
        textTopDescription.makeItTheme(.bold, 26, .textDark, .center, 36.0)
        labelStudent.text = "education".localized()
        labelJob.text = "Job".localized()
        labelEI.text = "for_educational_institute".localized()
        labelEC.text = "for_employer_companies".localized()
        labelKnowYourRights.text = "know_your_rights".localized()
        labelStudent.makeItTheme(.bold, 18, .textLight, .center, 26.0)
        labelJob.makeItTheme(.bold, 18, .textLight, .center, 26.0)
        labelEI.makeItTheme(.bold, 18, .textLight, .center, 26.0)
        labelEC.makeItTheme(.bold, 18, .textLight, .center, 26.0)
        labelKnowYourRights.makeItTheme(.bold, 18, .textDark, .center, 26.0)
        viewBottom.setLanguage()
        viewStudent.setRoundBorderColor(.clear, 1, 6)
        viewJob.setRoundBorderColor(.clear, 1, 6)
        viewForEducationalInstitutes.setRoundBorderColor(.clear, 1, 6)
        viewForEmployerCompanies.setRoundBorderColor(.clear, 1, 6)
        viewKnowYourRights.setRoundBorderColor(.clear, 1, 6)
        
        viewStudent.applyShadow()
        viewJob.applyShadow()
        viewForEducationalInstitutes.applyShadow()
        viewForEmployerCompanies.applyShadow()
        viewKnowYourRights.applyShadow()
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
extension AppHomeViewContoller {
    
    func setupNavigation() {
        self.navigationController?.navigationBar.isHidden = true
        UIApplication.shared.statusBarView?.backgroundColor = .appBGDark
    }
}
