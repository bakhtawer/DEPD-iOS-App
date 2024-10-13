//
//  SchoolDetailsViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 15/09/2024.
//

import UIKit

class SchoolDetailsViewController: BaseViewController {
    
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var imageSchool: UIImageView!
    @IBOutlet weak var labelSchoolName: UILabel!
    @IBOutlet weak var labelSchoolLocation: UILabel!
    @IBOutlet weak var viewTop: UIView!
    
    @IBOutlet weak var labelSchoolInfo: UILabel!
    @IBOutlet weak var labelSchoolInfoDetails: UILabel!
    @IBOutlet weak var buttonEditSchoolInfo: UIButton!
    
    @IBOutlet weak var labelAboutYourSchool: UILabel!
    @IBOutlet weak var labelAboutYourSchoolDetails: UILabel!
    @IBOutlet weak var buttonEditAbout: UIButton!
    
    @IBOutlet weak var labelAddiotnalInfo: UILabel!
    @IBOutlet weak var labelAddiontalInfoDetails: UILabel!
    @IBOutlet weak var buttonEditAdtionalInfo: UIButton!
    
    @IBOutlet weak var viewBottom: BottomView!
    private let service = APIService()
    var selectedSchool: InstituteModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setView()
        guard let selectedSchool = selectedSchool else { return }
        guard let image = URL(string: selectedSchool.ImageURL?.convertToHttps() ?? "") else { return }
        imageSchool.contentMode = .scaleAspectFill
        imageSchool.kf.setImage(with: image,
                                placeholder: UIImage(named: "studentplacehoder"))
        
        buttonEditSchoolInfo.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .schoolInfo
                view.selectedSchool = selectedSchool
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        buttonEditAbout.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .aboutYourSchool
                view.selectedSchool = selectedSchool
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        buttonEditAdtionalInfo.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .additionalInfo
                view.selectedSchool = selectedSchool
                openModuleOnNavigation(from: self, controller: view)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setView()
        setupNavigation()
    }
    
    private func setView() {
        
        viewImage.roundCorner(withRadis: viewImage.viewHeight.half)
        imageSchool.roundCorner(withRadis: imageSchool.viewHeight.half)
        viewTop.applyShadow()
        
        labelSchoolName.makeItTheme(.bold, 16, .textDark)
        labelSchoolLocation.makeItTheme(.regular, 13, .textLightGray)
        
        labelSchoolInfo.text = "school_information".localized()
        setMasterDetailsLabels(master: labelSchoolInfo, details: labelSchoolInfoDetails)
        
        labelAboutYourSchool.text = "about_your_school".localized()
        setMasterDetailsLabels(master: labelAboutYourSchool, details: labelAboutYourSchoolDetails)
        
        labelAddiotnalInfo.text = "additional_info".localized()
        setMasterDetailsLabels(master: labelAddiotnalInfo, details: labelAddiontalInfoDetails)
        
        
        guard let selectedSchool = selectedSchool else { return }
        let fullName = (selectedSchool.SchoolName ?? "")
        labelSchoolName.text = fullName
        labelSchoolLocation.text = selectedSchool.Location
        
        let schoolInfo = """
\("school_name".localized()): \(selectedSchool.SchoolName ?? "")
\("email".localized()): \(selectedSchool.EmailAddress ?? "N/A")
\("ntn_number".localized()): \(selectedSchool.NTNNUmber ?? "N/A")
\("contact_number".localized()): \(selectedSchool.ContactNumber ?? "N/A")
\("first_name".localized()): N/A
\("last_name".localized()): N/A
\("designation".localized()): \(selectedSchool.Designation ?? "N/A")
"""
        labelSchoolInfoDetails.text = schoolInfo
        
        labelAboutYourSchoolDetails.text = selectedSchool.AboutText ?? "N/A"
        
        let additionalInfo = """
\("establish_year".localized()): \(selectedSchool.EstablishedYear ?? 0)
\("location".localized()): \(selectedSchool.Location ?? "")
\("district".localized()): N/A
\("number_of_trained_teachers".localized()): \(selectedSchool.NumOfTrainedTeachers ?? 0)
\("available_seats_pwd".localized()): N/A
\("accessibility_material".localized()): \(selectedSchool.HasAccessibilityMaterial ?? false)
\("trained_teachers's".localized()): \(selectedSchool.HasTrainingMaterial ?? false)
\("free_or_paid_education".localized()): \(selectedSchool.FreeOrPaid ?? false)
\("number_of_total_students".localized()): \(selectedSchool.NumberOfSeats ?? 0)
"""
        labelAddiontalInfoDetails.text = additionalInfo
        
    }
    
    private func setMasterDetailsLabels (master: UILabel, details: UILabel) {
        master.makeItTheme(.bold, 14, .textDark)
        details.makeItTheme(.regular, 12, .textDark)
        details.textAlignment = .left
        if UserDefaults.selectedLanguage ==  "ur" || UserDefaults.selectedLanguage ==  "sd" {
            details.textAlignment = .right
        }
    }
}

extension SchoolDetailsViewController {
    
    func setupNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        self.setBackButton(.textDark).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
