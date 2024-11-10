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
    @IBOutlet weak var iconMaterial: UIImageView!
    
    @IBOutlet weak var bgtrainingMaterial: UIView!
    @IBOutlet weak var iconTrainingMaterial: UIImageView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            let request = Endpoint.applyForSchool(schoolID: data.InstituteId ?? -1, studentId: USM.shared.getUser().oStudentDetails?.id ?? -1).request!
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
        
        guard let imageSchoolUrl = URL(string: selectedInstitute?.ImageURL?.convertToHttps() ?? "") else { return }
        imageSchool.contentMode = .scaleAspectFill
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
        
        let accessibilityMaterial = data.HasAccessibilityMaterial ?? false
        let trainingMaterial = data.HasTrainingMaterial ?? false
        
        if accessibilityMaterial {
            bgMaterial.backgroundColor = .appGreen
            iconMaterial.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
        } else {
            bgMaterial.backgroundColor = .appError
            iconMaterial.image = UIImage(systemName: "xmark.circle")?.withRenderingMode(.alwaysTemplate)
        }
        
        if trainingMaterial {
            bgtrainingMaterial.backgroundColor = .appGreen
            iconTrainingMaterial.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
        } else {
            bgtrainingMaterial.backgroundColor = .appError
            iconTrainingMaterial.image = UIImage(systemName: "xmark.circle")?.withRenderingMode(.alwaysTemplate)
        }
        
        iconMaterial.tintColor = .white
        iconTrainingMaterial.tintColor = .white
        
        labelTrainedTeachers.text = "trained_teachers".localized()
        labelAccessibility.text = "trained_material".localized()
        labelAvailableSeats.text = "Available Seat".localized()
        labelTraningMaterial.text = "training_material".localized()
        labelGalery.text = "Gallery".localized()
        
        buttonAdmission.setTitle("send_addmission_request".localized(), for: .normal)
        buttonCancel.text = "cancel".localized()
        
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
}
extension InstituteDetailViewController {
    
    func setupNavigation() {
        self.navigationController?.navigationBar.isHidden = false
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
        return APPMetaDataHandler.shared.getPreviousClasses().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return APPMetaDataHandler.shared.getPreviousClasses()[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let data = APPMetaDataHandler.shared.getPreviousClasses()
        tfSelectClass.text = data[row].name
        selectedClasses = data[row]
    }
    
    @objc func doneButtonTapped() {
        UIViewController.top().view.endEditing(true)
    }
}
