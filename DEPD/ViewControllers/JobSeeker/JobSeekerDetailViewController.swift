//
//  JobSeekerDetailViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 31/10/2024.
//

import UIKit

class JobSeekerDetailViewController: BaseViewController  {
    
    @IBOutlet weak var viewBottom: BottomView!
    @IBOutlet weak var viewDetailsBG: UIView!
    @IBOutlet weak var imageCompany: UIImageView!
    @IBOutlet weak var labelCompanyPosting: UILabel!
    @IBOutlet weak var labelPostingDate: UILabel!
    @IBOutlet weak var lableCompanayName: UILabel!
    @IBOutlet weak var labelDescriptionTittle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var buttonApply: DEPDButton!
    
    
    var dataJob: CompanyModel?
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        viewBottom.setLanguage()
        
        setView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        setView()
    }
    
    private func setView() {
        labelCompanyPosting.text = dataJob?.PositionName
        labelPostingDate.text = dataJob?.PostedOnDateString
        lableCompanayName.text = dataJob?.CompanyName
        labelDescriptionTittle.text = "description".localized()
        labelDescription.text = dataJob?.DescriptionText
        
        
        viewDetailsBG.applyShadow()
//        imageCompany
        labelCompanyPosting.makeItTheme(.bold, 18, .textDark)
        labelPostingDate.makeItTheme(.bold, 16, .textDark)
        lableCompanayName.makeItTheme(.bold, 16, .textDark)
        labelDescriptionTittle.makeItTheme(.bold, 16, .textDark)
        labelDescription.makeItTheme(.regular, 14, .textLightGray)
        buttonApply.makeItTheme(text: "apply".localized(), .bold, 18, .appLight, .buttonBG, .appLight)
    }
    
}

extension JobSeekerDetailViewController {
    func setupNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        
        self.setMenuButton(.textDark).addTapGestureRecognizer {
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: SettingViewController.self)
            openModulePopOver(controller: view)
        }
        
        self.setBackButton(.appBackButton).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
