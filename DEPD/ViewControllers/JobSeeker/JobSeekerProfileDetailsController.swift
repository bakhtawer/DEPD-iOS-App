//
//  JobSeekerProfileDetailsController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 23/11/2024.
//

import UIKit

class JobSeekerProfileDetailsController: BaseViewController {
    
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
    
    @IBOutlet weak var viewBottom: BottomView!
    private let service = APIService()
    
    @IBOutlet weak var labelTitleSocialMultiMedia: UILabel!
    @IBOutlet weak var viewSocialMultiMedia: ImageScrollView!
    @IBOutlet weak var labelEmptySocialMultiMedia: UILabel!
    @IBOutlet weak var buttonEditSocialMultiMedia: UIButton!
    
    
    @IBOutlet weak var viewGapmultimedia: UIView!
    @IBOutlet weak var viewMasterSocialMultiMedia: UIView!
    @IBOutlet weak var viewGapSocialMedia: UIView!
    
    
    @IBOutlet weak var labelTitleEducation: UILabel!
    @IBOutlet weak var viewEducation: ThreeLabelListView!
    @IBOutlet weak var labelEmptyEducation: UILabel!
    @IBOutlet weak var buttonEducation: UIButton!
    
    @IBOutlet weak var labelTitleWorkExperience: UILabel!
    @IBOutlet weak var viewWorkExperience: ThreeLabelListView!
    @IBOutlet weak var labelEmptyWorkExperience: UILabel!
    @IBOutlet weak var buttonWorkExperience: UIButton!
    
    @IBOutlet weak var labelTitleTechSkills: UILabel!
    @IBOutlet weak var viewTechSkills: DisabilityListView!
    @IBOutlet weak var labelEmptyTechSkills: UILabel!
    @IBOutlet weak var buttonTechSkills: UIButton!
    
    
    @IBOutlet weak var labelTitleAdditionalInfo: UILabel!
    @IBOutlet weak var viewAdditionalInfo: ThreeLabelListView!
    @IBOutlet weak var labelEmptyAdditionalInfo: UILabel!
    @IBOutlet weak var buttonAdditionalInfo: UIButton!
    
    
    @IBOutlet weak var labelTitleCertification: UILabel!
    @IBOutlet weak var viewCertification: ThreeLabelListView!
    @IBOutlet weak var labelEmptyCertification: UILabel!
    @IBOutlet weak var buttonCertification: UIButton!
    
    
    @IBOutlet weak var labelTitleDocuments: UILabel!
    @IBOutlet weak var labelCV: UILabel!
    @IBOutlet weak var buttonCV: DEPDButton!
    @IBOutlet weak var viewCV: UIView!
    @IBOutlet weak var buttonViewCV: DEPDButton!
    
    @IBOutlet weak var viewDCerti: UIView!
    @IBOutlet weak var labelDisCer: UILabel!
    @IBOutlet weak var buttonDcer: DEPDButton!
    @IBOutlet weak var buttonViewCer: DEPDButton!
    
    @IBOutlet weak var buttonAddProfileImage: UIImageView!
    
    
    enum ImageType {
        case profile, certificate, cv
    }
    var imageType: ImageType = .profile
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setView()
        
        buttonEditSchoolInfo.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .personalInformation
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        buttonEducation.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .education
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        buttonWorkExperience.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .workExperience
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        buttonTechSkills.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .technicalSkills
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        buttonEditAbout.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .aboutMyself
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        buttonAdditionalInfo.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .jobAdditionalInfo
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        buttonCertification.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .certification
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        buttonAddProfileImage.addTapGestureRecognizer {[weak self] in
            self?.imageType = .profile
            self?.presentActionSheet()
        }
        
        buttonCV.addTapGestureRecognizer {[weak self] in
            self?.imageType = .cv
            self?.presentActionSheet()
        }
        
        buttonDcer.addTapGestureRecognizer {[weak self] in
            self?.imageType = .certificate
            self?.presentActionSheet()
        }
        
        buttonViewCV.addTapGestureRecognizer {[weak self] in
            guard let cv = USM.shared.getUser().jobSeekerDetailInfo?.cvFileUploadName?.convertToHttps() else { return }
            let webVC = DEPDWebViewController()
            webVC.urlString = cv
            openModuleOnNavigation(from: self, controller: webVC)
        }
        
        buttonViewCer.addTapGestureRecognizer {[weak self] in
            guard let certificate = USM.shared.getUser().jobSeekerDetailInfo?.disabilityCertificateURL?.convertToHttps() else { return }
            let webVC = DEPDWebViewController()
            webVC.urlString = certificate
            openModuleOnNavigation(from: self, controller: webVC)
        }
        
        guard let image = URL(string: USM.shared.getUser().jobSeekerDetailInfo?.profilePicture?.convertToHttps() ?? "") else { return }
        imageSchool.contentMode = .scaleAspectFill
        imageSchool.kf.setImage(with: image,
                                placeholder: UIImage(named: "studentplacehoder"))
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
        labelSchoolLocation.makeItTheme(.regular, 14, .textLightGray)
        
        labelSchoolInfo.text = "personal_information".localized()
        setMasterDetailsLabels(master: labelSchoolInfo, details: labelSchoolInfoDetails)
        
        labelAboutYourSchool.text = "about_myself".localized()
        setMasterDetailsLabels(master: labelAboutYourSchool, details: labelAboutYourSchoolDetails)
        
        
        labelTitleDocuments.text = "documents".localized()
        labelTitleDocuments.makeItTheme(.bold, 14, .textDark)
        labelCV.text = "cv_file".localized()
        labelDisCer.text = "disability_certificate".localized()
        labelCV.makeItTheme(.bold, 18, .textDark, .center, 20)
        labelDisCer.makeItTheme(.bold, 18, .textDark, .center, 20)
        viewCV.roundCorner(withRadis: 12)
        viewCV.applyShadow()
        viewDCerti.roundCorner(withRadis: 12)
        viewDCerti.applyShadow()
        buttonCV.makeItTheme(text: "upload".localized(), .bold, 12, .appLight, .appBlue, .appLight)
        buttonCV.makeButtonIconRight(named: "square.and.arrow.up")
        buttonViewCV.makeItTheme(text: "view".localized(), .bold, 12, .appLight, .appBlue, .appLight)
        buttonViewCV.makeButtonIconRight(named: "eye")
        buttonDcer.makeItTheme(text: "upload".localized(), .bold, 12, .appLight, .appBlue, .appLight)
        buttonDcer.makeButtonIconRight(named: "square.and.arrow.up")
        buttonViewCer.makeItTheme(text: "view".localized(), .bold, 12, .appLight, .appBlue, .appLight)
        buttonViewCer.makeButtonIconRight(named: "eye")
        
        let jobSeeker = USM.shared.getUser()
        
        labelSchoolName.text = USM.shared.getUserFullName()
        labelSchoolLocation.text = jobSeeker.jobSeekerDetailInfo?.address
        
        let personinfo = """
\("name".localized()): \(USM.shared.getUserFullName())
\("email".localized()): \(jobSeeker.jobSeekerDetailInfo?.emailAddress ?? "N/A")
\("address".localized()): \(jobSeeker.jobSeekerDetailInfo?.address ?? "N/A")
\("contact_number".localized()): \(USM.shared.getUser().contactNo ?? "N/A")
\("disability".localized()): \(String(describing: AMDH.shared.getDisabilities(byID: jobSeeker.jobSeekerDetailInfo?.disabilityId ?? -1)?.name?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""))
\("district".localized()): \(jobSeeker.jobSeekerDetailInfo?.district ?? "N/A")
\("cnic".localized()): \(USM.shared.getUser().cnic ?? "N/A")
\("gender".localized()): \(String(describing: AMDH.shared.getGenders(byID: jobSeeker.jobSeekerDetailInfo?.gender ?? -1)?.name))
\("dob".localized()): \(String(jobSeeker.jobSeekerDetailInfo?.dateOfBirth?.convertMicrosoftDateString ?? "N/A"))
"""
        labelSchoolInfoDetails.text = personinfo
        labelSchoolInfoDetails.makeItTheme(.regular, 14, .textDark, .left, 20)
        
        
        labelTitleEducation.text = "education".localized()
        labelTitleEducation.makeItTheme(.bold, 14, .textDark)
        labelEmptyEducation.text = ""
        labelEmptyEducation.makeItTheme(.regular, 12, .textDark)
        let jobSeekerEducationInfo = jobSeeker.jobSeekerDetailInfo?.jobSeekerEducationInfo ?? []
        viewEducation.jobSeekerEducationInfo = jobSeekerEducationInfo
        if jobSeekerEducationInfo.isEmpty { labelEmptyEducation.text = "nothing_to_show_in_the_gallery".localized() }
        
        labelTitleWorkExperience.text = "work_experience".localized()
        labelTitleWorkExperience.makeItTheme(.bold, 14, .textDark)
        labelEmptyWorkExperience.text = ""
        labelEmptyWorkExperience.makeItTheme(.regular, 12, .textDark)
        let jobSeekerWorkExperience = jobSeeker.jobSeekerDetailInfo?.jobSeekerWorkExperience ?? []
        viewWorkExperience.jobSeekerWorkExperience = jobSeekerWorkExperience
        if jobSeekerWorkExperience.isEmpty { labelEmptyWorkExperience.text = "nothing_to_show_in_the_gallery".localized() }
        
        labelTitleTechSkills.text = "technical_skills".localized()
        labelTitleTechSkills.makeItTheme(.bold, 14, .textDark)
        labelEmptyTechSkills.text = ""
        labelEmptyTechSkills.makeItTheme(.regular, 12, .textDark)
        let jobSeekerTechnicalSkill = jobSeeker.jobSeekerDetailInfo?.jobSeekerTechnicalSkill ?? []
        viewTechSkills.jobSeekerTechnicalSkill = jobSeekerTechnicalSkill
        if jobSeekerTechnicalSkill.isEmpty { labelEmptyTechSkills.text = "nothing_to_show_in_the_gallery".localized() }
        
        labelTitleAdditionalInfo.text = "additional_info".localized()
        labelTitleAdditionalInfo.makeItTheme(.bold, 14, .textDark)
        labelEmptyAdditionalInfo.text = ""
        labelEmptyAdditionalInfo.makeItTheme(.regular, 12, .textDark)
        let jobSeekerAdditionalInfo = jobSeeker.jobSeekerDetailInfo?.jobSeekerAdditionalInfo ?? []
        viewAdditionalInfo.jobSeekerAdditionalInfo = jobSeekerAdditionalInfo
        if jobSeekerTechnicalSkill.isEmpty { labelEmptyAdditionalInfo.text = "nothing_to_show_in_the_gallery".localized() }
        
        labelTitleCertification.text = "certification".localized()
        labelTitleCertification.makeItTheme(.bold, 14, .textDark)
        labelEmptyCertification.text = ""
        labelEmptyCertification.makeItTheme(.regular, 12, .textDark)
        let jobSeekerCertification = jobSeeker.jobSeekerDetailInfo?.jobSeekerCertification ?? []
        viewCertification.jobSeekerCertification = jobSeekerCertification
        if jobSeekerCertification.isEmpty { labelEmptyCertification.text = "nothing_to_show_in_the_gallery".localized() }
        
        labelAboutYourSchoolDetails.text = jobSeeker.jobSeekerDetailInfo?.aboutInfo?.aboutText ?? "N/A"
        labelAboutYourSchoolDetails.makeItTheme(.regular, 14, .textDark, .left, 20)
        
        
        viewEducation.onDeleteToggle = {[weak self] index in
            print("Index: viewEducation \(index)")
            let education = jobSeekerEducationInfo[index]
            guard let id = education.id,
                  let relId = USM.shared.getUser().jobSeekerDetailInfo?.id
            else { return }
            self?.presentActionSheetDelete(data: DeleteJobSeekerCreds(Id: id, RelId: relId), type: .education)
        }
        
        viewWorkExperience.onDeleteToggle = {[weak self]  index in
            print("Index: viewWorkExperience \(index)")
            
            let workExperience = jobSeekerWorkExperience[index]
            guard let id = workExperience.id,
                  let relId = USM.shared.getUser().jobSeekerDetailInfo?.id
            else { return }
            self?.presentActionSheetDelete(data: DeleteJobSeekerCreds(Id: id, RelId: relId), type: .work)
        }
        
        viewTechSkills.onToggle = {[weak self]  index in
            print("Index: viewTechSkills \(index)")
            
            let technicalSkill = jobSeekerTechnicalSkill[index]
            guard let id = technicalSkill.id,
                  let relId = USM.shared.getUser().jobSeekerDetailInfo?.id
            else { return }
            self?.presentActionSheetDelete(data: DeleteJobSeekerCreds(Id: id, RelId: relId), type: .techSkill)
        }
        
        viewAdditionalInfo.onDeleteToggle = {[weak self]  index in
            print("Index: additionalInfo \(index)")
            
            let additionalInfo = jobSeekerAdditionalInfo[index]
            guard let id = additionalInfo.id,
                  let relId = USM.shared.getUser().jobSeekerDetailInfo?.id
            else { return }
            self?.presentActionSheetDelete(data: DeleteJobSeekerCreds(Id: id, RelId: relId), type: .additionalInfo)
        }
        
        viewCertification.onDeleteToggle = {[weak self]  index in
            print("Index: viewCertification \(index)")
            
            let certification = jobSeekerCertification[index]
            guard let id = certification.id,
                  let relId = USM.shared.getUser().jobSeekerDetailInfo?.id
            else { return }
            self?.presentActionSheetDelete(data: DeleteJobSeekerCreds(Id: id, RelId: relId), type: .certification)
        }
    }
    
    private enum DeleteType {
        case education, techSkill, work, certification, additionalInfo
    }
    private func presentActionSheetDelete(data: DeleteJobSeekerCreds, type: DeleteType) {
        let actionSheet = UIAlertController(title: "Are you sure you want to delete this record?", message: nil, preferredStyle: .alert)
        actionSheet.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
            self.showLoadingIndicator(withDimView: true)
            func success(status: Bool) {
                DispatchQueue.main.async {[weak self] in self?.hideLoadingIndicator() }
                if status {
                    USM.shared.updatedUser {[weak self] status in
                        DispatchQueue.main.async {[weak self] in self?.setView() }
                    }
                }
            }
            switch type {
            case .education:
                JobManager.shared.deleteJobSeekerEducationSkills(data: data) {status in
                    success(status: status)
                }
            case .techSkill:
                JobManager.shared.deleteJobSeekerTechnicalSkills(data: data) {status in
                    success(status: status)
                }
            case .work:
                JobManager.shared.deleteJobSeekerWorkExperience(data: data) {status in
                    success(status: status)
                }
            case .certification:
                JobManager.shared.deleteJobSeekerCertification(data: data) {status in
                    success(status: status)
                }
            case .additionalInfo:
                JobManager.shared.deleteJobSeekerAdditionalInfo(data: data) {status in
                    success(status: status)
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

extension JobSeekerProfileDetailsController {
    func setupNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        self.setBackButton(.textDark).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

extension JobSeekerProfileDetailsController : UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate {
    private func presentActionSheet() {
        let actionSheet = UIAlertController(title: "Select Option", message: nil, preferredStyle: .actionSheet)
        
        switch imageType {
        case .profile:
            actionSheet.addAction(UIAlertAction(title: "Select Image", style: .default) { _ in
                self.openImagePicker()
            })
        case .certificate, .cv:
            actionSheet.addAction(UIAlertAction(title: "Select Image", style: .default) { _ in
                self.openImagePicker()
            })
            actionSheet.addAction(UIAlertAction(title: "Select Document", style: .default) { _ in
                self.openDocumentPicker()
            })
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    private func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func openDocumentPicker() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf, .image])
        documentPicker.delegate = self
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    // UIImagePickerControllerDelegate method
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            switch imageType {
            case .profile:
                imageSchool.image = image
                uploadProfilePicture(imageString: imageToByteString(image: image) ?? "")
            case .certificate:
                uploadCertificate(imageString: imageToByteString(image: image) ?? "")
            case .cv:
                uploadCV(imageString: imageToByteString(image: image) ?? "")
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // UIDocumentPickerDelegate method
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let documentURL = urls.first {
            print("Selected document URL: \(documentURL)")
            
            do {
                let pdfData = try Data(contentsOf: documentURL)
                let byteString = pdfData.base64EncodedString() // Convert to Base64 if needed
                
                print("PDF Byte String: \(byteString)") // Use this string for upload
                
                switch imageType {
                case .profile:
                    break
                case .certificate:
                    uploadCertificate(imageString: byteString)
                case .cv:
                    uploadCV(imageString: byteString)
                }
            } catch {
                SMM.shared.showError(title: "", message: "Error reading PDF data: \(error.localizedDescription)")
            }
        }
    }
    
    func imageToByteString(image: UIImage) -> String? {
        // Convert UIImage to Data (JPEG with 80% quality or PNG)
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return nil }
        // Convert Data to Base64 encoded string
        return imageData.base64EncodedString()
    }
    
    private func uploadProfilePicture(imageString: String) {
        self.showLoadingIndicator(withDimView: true)
        let data = UploadJobSeekerProfileImageCreds(profileImageName: imageString, ProfileImageByteString:"\(UUID().uuidString).jpg", UserID: USM.shared.getUser().jobSeekerDetailInfo?.userID ?? 0)
        JobManager.shared.uploadJobSeekerProfileImage(data: data) {[weak self] status in
            self?.hideLoadingIndicator()
            USM.shared.updatedUser {[weak self] status in
                DispatchQueue.main.async {[weak self] in self?.setView() }
            }
        }
    }
    private func uploadCV(imageString: String) {
        self.showLoadingIndicator(withDimView: true)
        let data = UploadJobSeekerCVCreds(CVFileUploadName:"\(UUID().uuidString)", CVFileUploadByteString: imageString, UserID: USM.shared.getUser().jobSeekerDetailInfo?.userID ?? 0)
        JobManager.shared.uploadJobSeekerCV(data: data) {[weak self] status in
            self?.hideLoadingIndicator()
            USM.shared.updatedUser {[weak self] status in
                DispatchQueue.main.async {[weak self] in self?.setView() }
            }
        }
    }
    private func uploadCertificate(imageString: String) {
        self.showLoadingIndicator(withDimView: true)
        let data = UploadDisabilityCertificateCreds(DisabilityCertificateName: "\(UUID().uuidString)", DisabilityCertificateByteString: imageString, UserID: USM.shared.getUser().jobSeekerDetailInfo?.userID ?? 0)
        JobManager.shared.uploadDisabilityCertificate(data: data) {[weak self] status in
            self?.hideLoadingIndicator()
            USM.shared.updatedUser {[weak self] status in
                DispatchQueue.main.async {[weak self] in self?.setView() }
            }
        }
    }
}
