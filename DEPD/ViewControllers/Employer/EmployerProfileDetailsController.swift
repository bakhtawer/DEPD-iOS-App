//
//  EmployerProfileDetailsController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 07/12/2024.
//


import UIKit

class EmployerProfileDetailsController: BaseViewController {
    
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var imageEmployer: UIImageView!
    @IBOutlet weak var labelEmployerName: UILabel!
    @IBOutlet weak var labelEmployerLocation: UILabel!
    @IBOutlet weak var viewTop: UIView!
    
    @IBOutlet weak var labelEmployerInfo: UILabel!
    @IBOutlet weak var labelEmployerInfoDetails: UILabel!
    @IBOutlet weak var buttonEditSchoolInfo: UIButton!
    
    @IBOutlet weak var labelAboutYourSelf: UILabel!
    @IBOutlet weak var labelAboutYourSelfDetails: UILabel!
    
    @IBOutlet weak var labelTitleSocailMediaLinks: UILabel!
    @IBOutlet weak var viewSocailMediaLinks: ImageScrollView!
    @IBOutlet weak var labelEmptySocailMediaLinks: UILabel!
    @IBOutlet weak var buttonSocailMediaLinks: UIButton!
    
    @IBOutlet weak var labelTitleWeProvide: UILabel!
    @IBOutlet weak var viewWeProvide: DisabilityListView!
    @IBOutlet weak var labelEmptyWeProvide: UILabel!
    @IBOutlet weak var buttonWeProvide: UIButton!
    
    @IBOutlet weak var labelTitleAccessibilityMaterial: UILabel!
    @IBOutlet weak var viewAccessibilityMaterial: DisabilityListView!
    @IBOutlet weak var labelEmptyAccessibilityMaterial: UILabel!
    @IBOutlet weak var buttonAccessibilityMaterial: UIButton!
    
    @IBOutlet weak var viewBottom: BottomView!
    private let service = APIService()
    
    
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
                view.type = .personalInformationEmployer
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        buttonSocailMediaLinks.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .socialMediaEmployer
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        buttonWeProvide.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .weProvideJobEmployer
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        buttonAccessibilityMaterial.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .accessibilityMaterialEmployer
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        buttonAddProfileImage.addTapGestureRecognizer {[weak self] in
            self?.imageType = .profile
            self?.presentActionSheet()
        }
        
        guard let image = URL(string: USM.shared.getUserImage()) else { return }
        imageEmployer.contentMode = .scaleAspectFill
        imageEmployer.kf.setImage(with: image,
                                  placeholder: UIImage(named: "studentplacehoder"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setView()
        setupNavigation()
    }
    
    private func setView() {
        
        self.setTitle("\("edit_profile".localized())")
        
        viewImage.roundCorner(withRadis: viewImage.viewHeight.half)
        imageEmployer.roundCorner(withRadis: imageEmployer.viewHeight.half)
        viewTop.applyShadow()
        
        labelEmployerName.makeItTheme(.bold, 16, .textDark)
        labelEmployerLocation.makeItTheme(.regular, 14, .textLightGray)
        
        labelEmployerInfo.text = "personal_information".localized()
        setMasterDetailsLabels(master: labelEmployerInfo, details: labelEmployerInfoDetails)
        
        labelAboutYourSelf.text = "about_your_company".localized()
        setMasterDetailsLabels(master: labelAboutYourSelf, details: labelAboutYourSelfDetails)
        
        
        let employer = USM.shared.getUser()
        
        labelEmployerName.text = USM.shared.getUserFullName()
        labelEmployerLocation.text = employer.companyDetailInfo?.location
        
        let personinfo = """
\("name".localized()): \(USM.shared.getUserFullName())
\("email".localized()): \(employer.companyDetailInfo?.emailAdress ?? "N/A")
\("address".localized()): \(employer.companyDetailInfo?.location ?? "N/A")
\("contact_number".localized()): \(USM.shared.getUser().contactNo ?? "N/A")
\("district".localized()): \(employer.companyDetailInfo?.district ?? "N/A")
\("cnic".localized()): \(USM.shared.getUser().cnic ?? "N/A")
\("ntn_number".localized()): \(employer.companyDetailInfo?.nTNNumber ?? "N/A")
\("designation".localized()): \(employer.companyDetailInfo?.designation ?? "N/A")
\("registration_number".localized()): \(employer.companyDetailInfo?.registirationNumber ?? "N/A")
\("availbale_seats_for_pwds".localized()): \(employer.companyDetailInfo?.availableQuotaForPWDs ?? "N/A")
\("website".localized()): \(employer.companyDetailInfo?.website ?? "N/A")
"""
        labelEmployerInfoDetails.text = personinfo
        labelEmployerInfoDetails.makeItTheme(.regular, 14, .textDark, nil, 20)
        
        labelAboutYourSelfDetails.text = "N/A"
        if let aboutEmployer = employer.companyDetailInfo?.aboutDescription,
           !aboutEmployer.isEmpty,
           aboutEmployer != " " {
            labelAboutYourSelfDetails.text = aboutEmployer
        }
        
        labelTitleSocailMediaLinks.text = "social_media_links".localized()
        labelTitleSocailMediaLinks.makeItTheme(.bold, 14, .textDark)
        labelEmptySocailMediaLinks.text = ""
        labelEmptySocailMediaLinks.makeItTheme(.regular, 12, .textDark)
        
        labelTitleWeProvide.text = "we_provide_job_for".localized()
        labelTitleWeProvide.makeItTheme(.bold, 14, .textDark)
        labelEmptyWeProvide.text = ""
        labelEmptyWeProvide.makeItTheme(.regular, 12, .textDark)
        
        
        labelTitleAccessibilityMaterial.text = "accessibility_material".localized()
        labelTitleAccessibilityMaterial.makeItTheme(.bold, 14, .textDark)
        labelEmptyAccessibilityMaterial.text = ""
        labelEmptyAccessibilityMaterial.makeItTheme(.regular, 12, .textDark)
        
        
        let socialMediaLinks = (employer.companyDetailInfo?.socialMedia ?? []).map { $0.SocialMediaLink?.convertToHttps() ?? ""}
        let listOflinksImages = (employer.companyDetailInfo?.socialMedia ?? []).map {$0.convertUrl()}
        viewSocailMediaLinks.imageURLs = listOflinksImages
        viewSocailMediaLinks.linksURLs = socialMediaLinks
        viewSocailMediaLinks.isLink = true
        viewSocailMediaLinks.isEditable = true
        if socialMediaLinks.isEmpty {
            labelEmptySocailMediaLinks.text = "update_this_record".localized()
        }
        viewSocailMediaLinks.viewController = self
        viewSocailMediaLinks.onDeleteToggle = {[weak self] index in
            print("delete \(index) :\(String(describing: employer.companyDetailInfo?.socialMedia?[index]))")
            let socialMedia = employer.companyDetailInfo?.socialMedia?[index]
            guard let id = socialMedia?.id,
                  let relId = USM.shared.getUser().companyDetailInfo?.companyId
            else { return }
            self?.presentActionSheetDelete(data: DeleteJobSeekerCreds(Id: id, RelId: relId), type: .socialMediaLink)
        }
        
        
        let listOfDisabilities = (employer.companyDetailInfo?.schoolAndCompanyDisabilityStatusInfo ?? []).map {$0.disabilityStatus?.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\r\n", with: "").replacingOccurrences(of: "\n", with: "") ?? ""}
        viewWeProvide.disabilities = listOfDisabilities
        if listOfDisabilities.isEmpty {
            labelEmptyWeProvide.text = "update_this_record".localized()
        }
        viewWeProvide.onToggle = { [weak self] index in
            print("delete \(index) :\(String(describing: employer.companyDetailInfo?.schoolAndCompanyDisabilityStatusInfo?[index]))")
            let disability = employer.companyDetailInfo?.schoolAndCompanyDisabilityStatusInfo?[index]
            guard let id = disability?.id,
                  let relId = USM.shared.getUser().companyDetailInfo?.companyId
            else { return }
            self?.presentActionSheetDelete(data: DeleteJobSeekerCreds(Id: id, RelId: relId), type: .disability)
        }
        
        
        labelEmptyAccessibilityMaterial.text = "update_this_record".localized()
    }
    
    private enum DeleteType {
        case socialMediaLink, disability, accesibilty
    }
    private func presentActionSheetDelete(data: DeleteJobSeekerCreds, type: DeleteType) {
        let actionSheet = UIAlertController(title: "are_you_sure_you_want_to_delete".localized(), message: nil, preferredStyle: .alert)
        actionSheet.addAction(UIAlertAction(title: "yes".localized(), style: .default) { _ in
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
            case .socialMediaLink:
                JobManager.shared.deleteJobSeekerEducationSkills(data: data) {status in
                    success(status: status)
                }
            case .disability:
                JobManager.shared.deleteJobSeekerEducationSkills(data: data) {status in
                    success(status: status)
                }
            case .accesibilty:
                JobManager.shared.deleteJobSeekerEducationSkills(data: data) {status in
                    success(status: status)
                }
            }
        })
        actionSheet.addAction(UIAlertAction(title: "no".localized(), style: .cancel, handler: nil))
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

extension EmployerProfileDetailsController {
    func setupNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        self.setBackButton(.textDark).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

extension EmployerProfileDetailsController : UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate {
    private func presentActionSheet() {
        let actionSheet = UIAlertController(title: "Select Option".localized(), message: nil, preferredStyle: .actionSheet)
        
        switch imageType {
        case .profile:
            actionSheet.addAction(UIAlertAction(title: "Select Image".localized(), style: .default) { _ in
                self.openImagePicker()
            })
        case .certificate, .cv:
            actionSheet.addAction(UIAlertAction(title: "Select Image".localized(), style: .default) { _ in
                self.openImagePicker()
            })
            actionSheet.addAction(UIAlertAction(title: "Select Document".localized(), style: .default) { _ in
                self.openDocumentPicker()
            })
        }
        
        actionSheet.addAction(UIAlertAction(title: "cancel".localized(), style: .cancel, handler: nil))
        
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
                imageEmployer.image = image
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
