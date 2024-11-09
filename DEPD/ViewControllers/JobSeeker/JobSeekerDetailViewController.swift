//
//  JobSeekerDetailViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 31/10/2024.
//

import UIKit

class JobSeekerDetailViewController: BaseViewController  {
    
    @IBOutlet weak var mainIcon: UIView!
    @IBOutlet weak var mainIconImage: UIImageView!
    @IBOutlet weak var buttonEdit: UIButton!
    @IBOutlet weak var viewTopBG: UIView!
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var schoolLocation: UILabel!
    @IBOutlet weak var schoolProfilePercentage: UILabel!
    
    @IBOutlet weak var labelEditProfile: UILabel!
    
    @IBOutlet weak var viewBottom: BottomView!

    
    @IBOutlet weak var viewApplications: UIView!
    @IBOutlet weak var buttonViewApplications: UIButton!
    @IBOutlet weak var buttonEditYourProfile: UIButton!
    
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
        
        buttonEdit.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let filterItems = [
                    FilterItem(type: .checkbox, title: "Registered User"),
                    FilterItem(type: .checkbox, title: "Pending User"),
                    FilterItem(type: .dropdown, title: "District", options: APPMetaDataHandler.shared.getDistrictsNames()),
                    FilterItem(type: .multiSelect, title: "Disability", options:APPMetaDataHandler.shared.getDisabilitiesNames())
                ]

                let filterVC = FilterViewController()
                filterVC.filterItems = filterItems
//                filterVC.selectedOptions = self?.selectedFilterItems ?? [:]
//                filterVC.delegate = self
                openModulePopOver(controller: filterVC)
                
//                let storyboard = getStoryBoard(.main)
//                let view = storyboard.instantiateViewController(ofType: SchoolDetailsViewController.self)
//                view.selectedSchool = self?.viewModel.selectedSchool
//                openModuleOnNavigation(from: self, controller: view)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        setView()
    }
    
    private func setView() {
        
        mainIcon.roundCorner(withRadis: mainIcon.viewHeight.half)
        mainIconImage.roundCorner(withRadis: mainIconImage.viewHeight.half)
//        viewTopBG.applyShadow()
        
        schoolName.makeItTheme(.bold, 20, .textDark)
        schoolLocation.makeItTheme(.regular, 16, .textLightGray)
        schoolProfilePercentage.makeItTheme(.regular, 16, .appBlue)

        labelEditProfile.text =  "\("edit_profile".localized())"
        
        schoolName.text = USM.shared.getUserFullName()
        
        
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
        
        
        buttonViewApplications.setTitle("\("find_job".localized())", for: .normal)
        buttonEditYourProfile.setTitle("\("my_applications".localized())", for: .normal)
        buttonViewApplications.makeItThemePrimary(14)
        buttonEditYourProfile.makeItThemeGreenPrimary(14)
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
