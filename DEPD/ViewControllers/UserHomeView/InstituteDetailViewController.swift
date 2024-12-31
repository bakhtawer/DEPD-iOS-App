//
//  InstituteDetailViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 27/07/2024.
//

import UIKit

class InstituteDetailViewController: BaseViewController {
    
    @IBOutlet weak var viewBottom: BottomView!
    var selectedInstitute: InstituteModel?
    private let service = APIService()
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageAdmin: UIImageView!
    @IBOutlet weak var labelTopLocation: UILabel!
    
    @IBOutlet weak var labelSchoolName: UILabel!
    @IBOutlet weak var labelSchoolLocation: UILabel!
    
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelAddressFull: UILabel!
    
    @IBOutlet weak var labelNumberOfTeachers: UILabel!
    @IBOutlet weak var labelNumberOfSeats: UILabel!
    
    @IBOutlet weak var bgMaterial: UIView!
    
    @IBOutlet weak var bgtrainingMaterial: UIView!
    
    @IBOutlet weak var buttonAdmission: UIButton!
    @IBOutlet weak var buttonCancel: UILabel!
    
    @IBOutlet weak var labelTrainedTeachers: UILabel!
    @IBOutlet weak var labelAccessibility: UILabel!
    @IBOutlet weak var labelAvailableSeats: UILabel!
    @IBOutlet weak var labelTraningMaterial: UILabel!
    @IBOutlet weak var labelGalery: UILabel!
    
    @IBOutlet weak var tfSelectClass: UITextField!
    
    @IBOutlet weak var imageSchool: UIImageView!
    
    private var selectedClasses: Classes? = nil
    
    @IBOutlet weak var imageGalleryView: ImageScrollView!
    @IBOutlet weak var labelNoGallery: UILabel!
    
    
    @IBOutlet weak var labelAboutSchool: UILabel!
    @IBOutlet weak var labelAboutSchoolDetail: UILabel!
    
    @IBOutlet weak var labelAccessibilitySeeAll: UILabel!
    @IBOutlet weak var labelTrainingMaterialSeeAll: UILabel!
    
    @IBOutlet weak var labelTitleSocialMediaLink: UILabel!
    @IBOutlet weak var viewSocialMediaLink: ImageScrollView!
    @IBOutlet weak var labelEmptySocialMediaLink: UILabel!
    @IBOutlet weak var viewTopUserInfo: UIView!
    
    @IBOutlet weak var lTrainedTeachers: UILabel!
    @IBOutlet weak var labelvaluetrainedTeachers: UILabel!
    
    @IBOutlet weak var lAvaialbeSeats: UILabel!
    @IBOutlet weak var labelValueSeats: UILabel!
    
    @IBOutlet weak var lAccessibilityMaterial: UILabel!
    @IBOutlet weak var iconAccessibilityMaterial: UIImageView!
    @IBOutlet weak var viewValueAccessibilityMaterial: UIView!
    
    @IBOutlet weak var lTrainingMaterial: UILabel!
    @IBOutlet weak var iconTrainingMaterial: UIImageView!
    @IBOutlet weak var viewValueTrainingMaterial: UIView!
    
    
    @IBOutlet weak var lSupportedDisabilities: UILabel!
    @IBOutlet weak var iconSupportedDisabilities: UIImageView!
    @IBOutlet weak var viewValueSupportedDisabilities: UIView!
    
    
    @IBOutlet weak var viewMainTrainedTeachers: UIView!
    @IBOutlet weak var viewMainAvailableSeat: UIView!
    @IBOutlet weak var viewMainAccessibilityMaterial: UIView!
    @IBOutlet weak var viewmainTraingmaterial: UIView!
    @IBOutlet weak var viewMainSupportedDisabilities: UIView!
    
    
    @IBOutlet weak var oldViewDetails: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewTopUserInfo.isHidden = true
        oldViewDetails.isHidden = true
        
        setupNavigation()
        setView()
        guard let data = selectedInstitute else { return }
        buttonCancel.addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        buttonAdmission.addTapGestureRecognizer {[weak self] in
            guard let classes = self?.selectedClasses else {
                SMM.shared.showError(title: "", message: "Please select class");
                return
            }
            let request = Endpoint.applyForSchool(schoolID: data.InstituteId ?? -1, studentId: USM.shared.getUser().oStudentDetails?.studentId ?? -1).request!
            self?.service.makeRequest(with: request, respModel: ApiResponse<String>.self) { userResponse, error in
                if let error = error { print("DEBUG PRINT:", error); return }
                if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong"); return }
                
                DispatchQueue.main.async {
                    let storyboard = getStoryBoard(.main)
                    let contentVC = storyboard.instantiateViewController(ofType: ThankYouViewController.self)
                    contentVC.messageThankYou = .yourSchoolHasBeen(self?.selectedInstitute?.SchoolName ?? "N/A")
                    contentVC.moveThankYou = .home
                    openModuleOverFullScreen(controller: contentVC)
                }
            }
        }
        
        setUpClass()
        
        self.setTitle(selectedInstitute?.SchoolName ?? "")
        
        
        viewValueAccessibilityMaterial.addTapGestureRecognizer {[weak self] in
            self?.setUpAccessibility()
        }
        viewValueTrainingMaterial.addTapGestureRecognizer {[weak self] in
            self?.setUpTraining()
        }
        
        viewValueSupportedDisabilities.addTapGestureRecognizer {[weak self] in
            self?.setUpSupportedDisabilities()
        }
        
        imageSchool.backgroundColor = .appBorder.withAlphaComponent(0.35)
        guard let imageSchoolUrl = URL(string: selectedInstitute?.ImageURL?.convertToHttps() ?? "") else { return }
        imageSchool.contentMode = .scaleAspectFit
        imageSchool.kf.setImage(with: imageSchoolUrl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setView()
    }
    
    private func setView() {
        guard let data = selectedInstitute else { return }
        
        labelName.text = USM.shared.getUserFullName()
        labelTopLocation.text = USM.shared.getUser().oStudentDetails?.district
        labelSchoolName.text = data.SchoolName
        labelSchoolLocation.text = data.Location
        
        labelPhone.text = data.ContactNumber
        labelEmail.text = data.EmailAddress
        labelAddressFull.text = data.Location
        
        labelNumberOfTeachers.text = "\(data.NumOfTrainedTeachers ?? 0)"
        labelNumberOfSeats.text = "\(data.NumberOfSeats ?? 0)"
        
        
        labelAboutSchool.text = "about_your_school".localized()
        labelAboutSchool.makeItTheme(.bold, 16, .textDark)
        
        labelAboutSchoolDetail.text = data.AboutText ?? "N/A"
        labelAboutSchoolDetail.makeItTheme(.regular, 12, .textDark)
        
        let accessibilityMaterial = data.AccebilityMaterialListInfo?.isEmpty ?? false
        let trainingMaterial = data.TrainingMaterialList?.isEmpty ?? false
        
        if !accessibilityMaterial {
            bgMaterial.backgroundColor = .appGreen
        } else {
            bgMaterial.backgroundColor = .appError
        }
        
        if !trainingMaterial {
            bgtrainingMaterial.backgroundColor = .appGreen
        } else {
            bgtrainingMaterial.backgroundColor = .appError
        }
        
        labelTrainedTeachers.text = "trained_teachers".localized()
        labelAccessibility.text = "trained_material".localized()
        labelAvailableSeats.text = "Available Seat".localized()
        labelTraningMaterial.text = "training_material".localized()
        labelGalery.text = "Gallery".localized()
        
        buttonAdmission.setTitle("send_addmission_request".localized(), for: .normal)
        buttonCancel.text = "cancel".localized()
        
        lTrainedTeachers.text = "trained_teachers".localized()
        labelvaluetrainedTeachers.text = "\(data.NumOfTrainedTeachers ?? 0)"
        
        lAvaialbeSeats.text = "Available Seat".localized()
        labelValueSeats.text = "\(data.NumberOfSeats ?? 0)"
        
        lAccessibilityMaterial.text = "trained_material".localized()
        if !trainingMaterial {
            iconAccessibilityMaterial.image = UIImage(systemName: "chevron.down.circle")?.withRenderingMode(.alwaysTemplate)
            viewValueAccessibilityMaterial.backgroundColor = .appGreen
        } else {
            iconAccessibilityMaterial.image = UIImage(systemName: "xmark.circle")?.withRenderingMode(.alwaysTemplate)
            viewValueAccessibilityMaterial.backgroundColor = .appError
        }
        
        lTrainingMaterial.text = "training_material".localized()
        if !trainingMaterial {
            iconTrainingMaterial.image = UIImage(systemName: "chevron.down.circle")?.withRenderingMode(.alwaysTemplate)
            viewValueTrainingMaterial.backgroundColor = .appGreen
        } else {
            iconTrainingMaterial.image = UIImage(systemName: "xmark.circle")?.withRenderingMode(.alwaysTemplate)
            viewValueTrainingMaterial.backgroundColor = .appError
        }
        
        let supported = data.schoolAndCompanyDisabilityStatusInfo?.isEmpty ?? false
        lSupportedDisabilities.text = "supported_disabilities".localized()
        if !supported {
            iconSupportedDisabilities.image = UIImage(systemName: "chevron.down.circle")?.withRenderingMode(.alwaysTemplate)
            viewValueSupportedDisabilities.backgroundColor = .appGreen
        } else {
            iconSupportedDisabilities.image = UIImage(systemName: "xmark.circle")?.withRenderingMode(.alwaysTemplate)
            viewValueSupportedDisabilities.backgroundColor = .appError
        }
        
        
        viewMainTrainedTeachers.roundCorner(withRadis: 6)
        viewMainAvailableSeat.roundCorner(withRadis: 6)
        viewMainAccessibilityMaterial.roundCorner(withRadis: 6)
        viewmainTraingmaterial.roundCorner(withRadis: 6)
        viewMainSupportedDisabilities.roundCorner(withRadis: 6)
        
        lTrainedTeachers.makeItTheme(.regular, 12)
        lAccessibilityMaterial.makeItTheme(.regular, 12)
        lTrainingMaterial.makeItTheme(.regular, 12)
        lSupportedDisabilities.makeItTheme(.regular, 12)
        lAvaialbeSeats.makeItTheme(.regular, 12)
        
        labelvaluetrainedTeachers.makeItTheme(.bold, 12,.appLight)
        labelValueSeats.makeItTheme(.bold, 12,.appLight)
        
        
        buttonAdmission.makeItThemePrimary(18)
        buttonCancel.makeItTheme(.regular, 12, .textLightGray)
        
        labelName.makeItTheme(.bold, 22)
        
        labelSchoolName.makeItTheme(.bold, 18)
        labelSchoolLocation.makeItTheme(.medium, 16)
        
        labelPhone.makeItTheme(.bold, 12)
        labelEmail.makeItTheme(.bold, 12)
        labelAddressFull.makeItTheme(.bold, 12)
        
        labelTrainedTeachers.makeItTheme(.regular, 10)
        labelAccessibility.makeItTheme(.regular, 10)
        labelAvailableSeats.makeItTheme(.regular, 10)
        labelTraningMaterial.makeItTheme(.regular, 10)
        
        labelAccessibilitySeeAll.text = "see_all".localized()
        labelTrainingMaterialSeeAll.text = "see_all".localized()
        
        labelAccessibilitySeeAll.makeItTheme(.regular, 12,.textLight)
        labelTrainingMaterialSeeAll.makeItTheme(.regular, 12, .textLight)
        
        
        
        labelGalery.makeItTheme(.bold, 16)
        
        labelNoGallery.text = ""
        labelNoGallery.makeItTheme(.regular, 16)
        
        let listOfImages = (selectedInstitute?.SchoolMultiMediaList ?? []).map {$0.FileURLWithBaseUrl?.convertToHttps() ?? ""}
        imageGalleryView.imageURLs = listOfImages
        if listOfImages.isEmpty {
            labelNoGallery.text = "nothing_to_show_in_the_gallery".localized()
        }
        
//        imageGalleryView.imageURLs = ["https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png", "https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp", "https://gratisography.com/wp-content/uploads/2024/10/gratisography-cool-cat-800x525.jpg",
//        "https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png", "https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp", "https://gratisography.com/wp-content/uploads/2024/10/gratisography-cool-cat-800x525.jpg",
//                                      "https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png", "https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp", "https://gratisography.com/wp-content/uploads/2024/10/gratisography-cool-cat-800x525.jpg"] // Add URLs
        imageGalleryView.viewController = self
        
        
        labelTitleSocialMediaLink.text = "socail_media_links".localized()
        labelTitleSocialMediaLink.makeItTheme(.bold, 16)
        labelEmptySocialMediaLink.text = ""
        labelEmptySocialMediaLink.makeItTheme(.regular, 12)
        
        let listOflinks = (selectedInstitute?.schoolSocialMediaInfo ?? []).map { $0.SocialMediaLink?.convertToHttps() ?? ""}
        let listOflinksImages = (selectedInstitute?.schoolSocialMediaInfo ?? []).map {$0.convertUrl()}
        viewSocialMediaLink.imageURLs = listOflinksImages
        viewSocialMediaLink.linksURLs = listOflinks
        viewSocialMediaLink.isLink = true
        viewSocialMediaLink.isEditable = false
        if listOflinks.isEmpty {
            labelEmptySocialMediaLink.text = "nothing_to_show_in_the_gallery".localized()
        }
        viewSocialMediaLink.viewController = self
        
        imageAdmin.roundCorner(withRadis: imageAdmin.viewHeight.half)
        guard let image = URL(string: USM.shared.getUserImage()) else { return }
        imageAdmin.contentMode = .scaleAspectFit
        imageAdmin.kf.setImage(with: image,
                               placeholder: UIImage(named: "studentplacehoder"))
        
    }
    
    private func setUpClass() {
        tfSelectClass.placeholder = "select_class".localized()
        tfSelectClass.borderStyle = .roundedRect
        tfSelectClass.tag = 120
        tfSelectClass.makeItThemeTF() // Apply custom theme
        
        // Create the picker
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 910
        
        // Set the picker as the input view for the textField
        tfSelectClass.inputView = pickerView
        
        let dropdownIcon = UIImageView(image: UIImage(systemName: "chevron.down"))
        dropdownIcon.contentMode = .scaleAspectFit
        dropdownIcon.tintColor = .textDark
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: dropdownIcon.frame.width + 32, height: dropdownIcon.frame.height))
        dropdownIcon.frame = CGRect(x: 16, y: 0, width: dropdownIcon.frame.width, height: dropdownIcon.frame.height)
        containerView.addSubview(dropdownIcon)
        
        if UserDefaults.selectedLanguage ==  "ur" || UserDefaults.selectedLanguage ==  "sd" {
            tfSelectClass.leftView = containerView
            tfSelectClass.leftViewMode = .always
        } else {
            tfSelectClass.rightView = containerView
            tfSelectClass.rightViewMode = .always
        }
        
        // Add a toolbar with a "Done" button to dismiss the picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        tfSelectClass.inputAccessoryView = toolbar
    }
    
    private func setUpAccessibility() {
        let tempTF = UITextField(frame: CGRect(x: -100, y: -200, width: 20, height: 20))
        
        // Create the picker
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 920
        
        // Set the picker as the input view for the textField
        tempTF.inputView = pickerView
        
        // Add a toolbar with a "Done" button to dismiss the picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        tempTF.inputAccessoryView = toolbar
        
        self.view.addSubview(tempTF)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ){
            tempTF.becomeFirstResponder()
        }
    }
    
    private func setUpTraining() {
        let tempTF = UITextField(frame: CGRect(x: -100, y: -200, width: 20, height: 20))
        
        // Create the picker
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 930
        
        // Set the picker as the input view for the textField
        tempTF.inputView = pickerView
        
        // Add a toolbar with a "Done" button to dismiss the picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        tempTF.inputAccessoryView = toolbar
        
        self.view.addSubview(tempTF)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ){
            tempTF.becomeFirstResponder()
        }
    }
    
    private func setUpSupportedDisabilities() {
        let tempTF = UITextField(frame: CGRect(x: -100, y: -200, width: 20, height: 20))
        
        // Create the picker
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 940
        
        // Set the picker as the input view for the textField
        tempTF.inputView = pickerView
        
        // Add a toolbar with a "Done" button to dismiss the picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        tempTF.inputAccessoryView = toolbar
        
        self.view.addSubview(tempTF)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ){
            tempTF.becomeFirstResponder()
        }
    }
}
extension InstituteDetailViewController {
    
    func setupNavigation() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.setNavBarColor(.appBG)
        self.setBackButton(.textDark).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

extension InstituteDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 910: return APPMetaDataHandler.shared.getPreviousClasses().count
        case 920: return selectedInstitute?.AccebilityMaterialListInfo?.count ?? 0
        case 930: return selectedInstitute?.TrainingMaterialList?.count ?? 0
        case 940: return selectedInstitute?.schoolAndCompanyDisabilityStatusInfo?.count ?? 0
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 920: return selectedInstitute?.AccebilityMaterialListInfo?[row].materialName ?? "N/A"
        case 930: return selectedInstitute?.TrainingMaterialList?[row].materialName ?? "N/A"
        case 940: return selectedInstitute?.schoolAndCompanyDisabilityStatusInfo?[row].disabilityStatus ?? "N/A"
        default: return APPMetaDataHandler.shared.getPreviousClasses()[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 920: break
        case 930: break
        case 940: break
        default:
            let data = APPMetaDataHandler.shared.getPreviousClasses()
            tfSelectClass.text = data[row].name
            selectedClasses = data[row]
        }
    }
    
    @objc func doneButtonTapped() {
        UIViewController.top().view.endEditing(true)
    }
}
