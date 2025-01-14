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
    
    @IBOutlet weak var labelTitleSocialMultiMedia: UILabel!
    @IBOutlet weak var viewSocialMultiMedia: ImageScrollView!
    @IBOutlet weak var labelEmptySocialMultiMedia: UILabel!
    @IBOutlet weak var buttonEditSocialMultiMedia: UIButton!
    
    @IBOutlet weak var labelTitleSocialMediaLink: UILabel!
    @IBOutlet weak var viewSocialMediaLink: ImageScrollView!
    @IBOutlet weak var labelEmptySocialMediaLink: UILabel!
    @IBOutlet weak var buttonEditSocialMediaLink: UIButton!
    
    @IBOutlet weak var labelTitleWeCanEducate: UILabel!
    @IBOutlet weak var viewWeCanEducate: DisabilityListView!
    @IBOutlet weak var labelEmptyWeCanEducate: UILabel!
    @IBOutlet weak var buttonWeCanEducate: UIButton!
    
    
    @IBOutlet weak var viewGapmultimedia: UIView!
    @IBOutlet weak var viewMasterSocialMultiMedia: UIView!
    @IBOutlet weak var viewGapSocialMedia: UIView!
    @IBOutlet weak var viewMasterSocialMediaLinks: UIView!
    @IBOutlet weak var viewGapWeCan: UIView!
    @IBOutlet weak var viewMasterWeCanEducate: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setView()
        
//        guard let selectedSchool = selectedSchool else { return }
        
        buttonEditSchoolInfo.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .schoolInfo
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        buttonEditAbout.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .aboutYourSchool
//                view.selectedSchool = selectedSchool
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        guard let selectedSchool = selectedSchool else { return }
        
        buttonEditAdtionalInfo.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .additionalInfo
                view.selectedSchool = selectedSchool
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        
        buttonEditSocialMultiMedia.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .schoolSocialMultiMedia
                view.selectedSchool = selectedSchool
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        buttonEditSocialMediaLink.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .schoolSocialMedia
                view.selectedSchool = selectedSchool
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        buttonWeCanEducate.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .schoolWeCanEducate
                view.selectedSchool = selectedSchool
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        
        
        guard let image = URL(string: USM.shared.getUserImage()) else { return }
        imageSchool.contentMode = .scaleAspectFill
        imageSchool.kf.setImage(with: image,
                                placeholder: UIImage(named: "studentplacehoder"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        USM.shared.getUserProfile() {_ in 
            DispatchQueue.main.async {[weak self] in
                self?.setView()
                self?.setupNavigation()
            }
        }
    }
    
    private func setView() {
        
        viewImage.roundCorner(withRadis: viewImage.viewHeight.half)
        imageSchool.roundCorner(withRadis: imageSchool.viewHeight.half)
        viewTop.applyShadow()
        
        labelSchoolName.makeItTheme(.bold, 16, .textDark)
        labelSchoolLocation.makeItTheme(.regular, 14, .textLightGray)
        
        labelSchoolInfo.text = "school_information".localized()
        setMasterDetailsLabels(master: labelSchoolInfo, details: labelSchoolInfoDetails)
        
        labelAboutYourSchool.text = "about_your_school".localized()
        setMasterDetailsLabels(master: labelAboutYourSchool, details: labelAboutYourSchoolDetails)
        
        labelAddiotnalInfo.text = "additional_info".localized()
        setMasterDetailsLabels(master: labelAddiotnalInfo, details: labelAddiontalInfoDetails)
        
        let school = USM.shared.getUser().schoolDetailInfo
        
        
        labelSchoolName.text = school?.schoolName
        labelSchoolLocation.text = school?.location
        
        let schoolInfo = """
\("school_name".localized()): \(school?.schoolName ?? "")
\("email".localized()): \(school?.emailAddress ?? "N/A")
\("ntn_number".localized()): \(school?.ntnNumber ?? "N/A")
\("contact_number".localized()): \(USM.shared.getUser().contactNo ?? "N/A")
\("cnic".localized()): \(USM.shared.getUser().cnic ?? "N/A")
\("first_name".localized()): \(USM.shared.getUser().firstName ?? "N/A")
\("last_name".localized()): \(USM.shared.getUser().lastName ?? "N/A")
\("designation".localized()): \(school?.designation ?? "N/A")
"""
        labelSchoolInfoDetails.text = schoolInfo
        labelSchoolInfoDetails.makeItTheme(.regular, 14, .textDark, nil, 20)
        
        labelAboutYourSchoolDetails.text = school?.aboutText ?? "N/A"
        labelAboutYourSchoolDetails.makeItTheme(.regular, 14, .textDark, nil, 20)
        
        let additionalInfo = """
\("establish_year".localized()): \(school?.establishedYear ?? 0)
\("location".localized()): \(school?.location ?? "")
\("district".localized()):\(USM.shared.getUser().schoolDetailInfo?.district ?? "")
\("number_of_trained_teachers".localized()): \(school?.numberOfTrainedTeachers ?? 0)
\("available_seats_pwd".localized()): N/A
\("accessibility_material".localized()): \(school?.hasAccessibilityMaterial ?? false)
\("free_or_paid_education".localized()): \(APPMetaDataHandler.shared.getFreePaidFromInt(value: SchoolManager.shared.selectedSchool?.FreeOrPaid ?? 0))
\("number_of_total_students".localized()): \(school?.availableSeats ?? 0)
"""
        labelAddiontalInfoDetails.text = additionalInfo
        labelAddiontalInfoDetails.makeItTheme(.regular, 14, .textDark, nil, 20)
        
        labelTitleSocialMultiMedia.text = "school_multi_media".localized()
        labelTitleSocialMultiMedia.makeItTheme(.bold, 14, .textDark)
        labelEmptySocialMultiMedia.text = ""
        labelEmptySocialMultiMedia.makeItTheme(.regular, 12, .textDark)
        
        
        guard let selectedSchool = USM.shared.getUser().schoolDetailInfo else {
            //Hide here views
            viewGapmultimedia.isHidden = true
            viewMasterSocialMultiMedia.isHidden = true
            viewGapSocialMedia.isHidden = true
            viewMasterSocialMediaLinks.isHidden = true
            viewGapWeCan.isHidden = true
            viewMasterWeCanEducate.isHidden = true
            return }
        
        
        let listOfImages = (selectedSchool.SchoolMultiMediaList ?? []).map {$0.FileURL?.convertToHttps() ?? ""}
        viewSocialMultiMedia.imageURLs = listOfImages
        if listOfImages.isEmpty {
            labelEmptySocialMultiMedia.text = "nothing_to_show_in_the_gallery".localized()
        }
        viewSocialMultiMedia.isEditable = true
        viewSocialMultiMedia.viewController = self
        viewSocialMultiMedia.onDeleteToggle = { index in
            print("delete \(index) :\(selectedSchool.SchoolMultiMediaList?[index])")
            guard let disabilityId = selectedSchool.SchoolMultiMediaList?[index].schoolMultiMediaID,
                  disabilityId != -1,
                  let userID = USM.shared.getUser().id
            else {
                SMM().showError(title: "Sorry", message: "Please select the Multi Media")
                return
            }
            self.presentActionSheetDeleteMultimedia(data: DeleteById(Id: disabilityId, UserId: userID))
        }
        
        labelTitleSocialMediaLink.text = "socail_media_links".localized()
        labelTitleSocialMediaLink.makeItTheme(.bold, 14, .textDark)
        labelEmptySocialMediaLink.text = ""
        labelEmptySocialMediaLink.makeItTheme(.regular, 12, .textDark)
        
        let listOflinks = (selectedSchool.schoolSocialMediaInfo ?? []).map { $0.SocialMediaLink?.convertToHttps() ?? ""}
        let listOflinksImages = (selectedSchool.schoolSocialMediaInfo ?? []).map {$0.convertUrl()}
        viewSocialMediaLink.imageURLs = listOflinksImages
        viewSocialMediaLink.linksURLs = listOflinks
        viewSocialMediaLink.isLink = true
        viewSocialMediaLink.isEditable = true
        if listOflinks.isEmpty {
            labelEmptySocialMediaLink.text = "nothing_to_show_in_the_gallery".localized()
        }
        viewSocialMediaLink.viewController = self
        
        viewSocialMediaLink.onDeleteToggle = { index in
            print("delete \(index) :\(selectedSchool.schoolSocialMediaInfo?[index])")
            guard let disabilityId = selectedSchool.schoolSocialMediaInfo?[index].id,
                  disabilityId != -1,
                  let userID = USM.shared.getUser().id
            else {
                SMM().showError(title: "Sorry", message: "Please select the disability")
                return
            }
            self.presentActionSheetDeleteLinks(data: DeleteById(Id: disabilityId, UserId: userID))
        }
        
        
        labelTitleWeCanEducate.text = "we_can_educate".localized()
        labelTitleWeCanEducate.makeItTheme(.bold, 14, .textDark)
        labelEmptyWeCanEducate.text = ""
        labelEmptyWeCanEducate.makeItTheme(.regular, 12, .textDark)
        
        let listOfDisabilities = (selectedSchool.schoolAndCompanyDisabilityStatusInfo ?? []).map {$0.disabilityStatus?.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\r\n", with: "").replacingOccurrences(of: "\n", with: "") ?? ""}
        viewWeCanEducate.disabilities = listOfDisabilities
        if listOfDisabilities.isEmpty {
            labelEmptyWeCanEducate.text = "nothing_to_show_in_the_gallery".localized()
        }
        viewWeCanEducate.onToggle = { index in
            print("delete \(index) :\(selectedSchool.schoolAndCompanyDisabilityStatusInfo?[index])")
            guard let disabilityId = selectedSchool.schoolAndCompanyDisabilityStatusInfo?[index].disabilityStatusId,
                  disabilityId != -1,
                  let userID = USM.shared.getUser().id
            else {
                SMM().showError(title: "Sorry", message: "Please select the disability")
                return
            }
            self.presentActionSheetDeleteDisability(data: DeleteById(Id: disabilityId, UserId: userID))
        }
        
    }
    
    private func presentActionSheetDeleteDisability(data: DeleteById) {
        let actionSheet = UIAlertController(title: "Are you sure you want to delete this record?", message: nil, preferredStyle: .alert)
        
        actionSheet.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
            self.showLoadingIndicator(withDimView: true)
            SchoolManager.shared.deleteDisabilityStatus(data: data) {[weak self] status in
                self?.hideLoadingIndicator()
                if status {
                    SchoolManager.shared.fetchAllSchoolsForSchool {[weak self] status in
                        DispatchQueue.main.async {[weak self] in self?.setView() }
                    }
                }
            }
        })
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    private func presentActionSheetDeleteLinks(data: DeleteById) {
        let actionSheet = UIAlertController(title: "Are you sure you want to delete this record?", message: nil, preferredStyle: .alert)
        
        actionSheet.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
            self.showLoadingIndicator(withDimView: true)
            SchoolManager.shared.deleteSocialMediaLink(data: data) {[weak self] status in
                self?.hideLoadingIndicator()
                if status {
                    SchoolManager.shared.fetchAllSchoolsForSchool {[weak self] status in
                        DispatchQueue.main.async {[weak self] in self?.setView() }
                    }
                }
            }
        })
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    private func presentActionSheetDeleteMultimedia(data: DeleteById) {
        let actionSheet = UIAlertController(title: "Are you sure you want to delete this record?", message: nil, preferredStyle: .alert)
        
        actionSheet.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
            self.showLoadingIndicator(withDimView: true)
            SchoolManager.shared.deleteSocialMultiMediaLink(data: data) {[weak self] status in
                self?.hideLoadingIndicator()
                if status {
                    SchoolManager.shared.fetchAllSchoolsForSchool { status in
                        DispatchQueue.main.async {[weak self] in self?.setView() }
                    }
                }
            }
        })
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
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
