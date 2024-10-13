//
//  FormBuilderViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 28/09/2024.
//

import UIKit

import UIKit

// Enum to represent field types
enum FieldType {
    case text
    case number
    case date
    case email
    case dropdown(options: [String])
    case textLong
}

// Struct to represent each form field
struct FormField: Equatable {
    static func == (lhs: FormField, rhs: FormField) -> Bool {
        lhs.id == rhs.id
    }
    let id = UUID()
    let fieldType: FieldType
    let placeholder: String
    let name: String
    let value: String?
    let isRequired: Bool
}

protocol FormBuilderProtocol: AnyObject {
    func submitForm(data:  [String: Any])
}

class FormBuilderViewController: BaseViewController {
    
    @IBOutlet weak var formBuilderView: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    
    let service = APIService()
    
    enum FormType {
        case schoolInfo
        case aboutYourSchool
        case additionalInfo
//        case socialMediaLinks
//        case socialMediaMedia
//        case weCanEducate
        case general
    }
    
    var type: FormType = .general
    
    var selectedSchool: InstituteModel?
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        labelTitle.makeItTheme(.bold, 18)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        setUpView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        view.backgroundColor = .appBG
        
        APPMetaDataHandler.shared.populateDistricts()
    }
    
    private func setUpView() {
        let fields: [FormField]
        
        switch type {
        case .schoolInfo:
            self.setTitle("school_information".localized())
            labelTitle.text = "school_information".localized()
            fields = populateForSchoolInfo()
        case .aboutYourSchool:
            self.setTitle("about_your_school".localized())
            labelTitle.text = "about_your_school".localized()
            fields = [
                FormField(fieldType: .textLong,
                          placeholder: "about_your_school".localized(),
                          name: "about_your_school",
                          value: selectedSchool?.AboutText,
                          isRequired: false)
            ]
        case .additionalInfo:
            self.setTitle("additional_info".localized())
            labelTitle.text = "additional_info".localized()
            fields = populateForAdditionalInfo()
        case .general:
            self.setTitle("")
            fields = [
                FormField(fieldType: .text, placeholder: "First Name", name: "firstName",
                          value: nil, isRequired: true),
                FormField(fieldType: .text, placeholder: "Last Name", name: "lastName", value: nil, isRequired: false)
            ]
        }
        
        let formBuilder = FormBuilderView(fields: fields)
        formBuilder.backgroundColor = .appBG
        formBuilder.translatesAutoresizingMaskIntoConstraints = false
        formBuilder.delegate = self
        formBuilderView.addSubview(formBuilder)
        
        formBuilderView.backgroundColor = .appBG
        
        // Pin the formBuilderView to its container (scrollView inside stackView)
        NSLayoutConstraint.activate([
            formBuilder.topAnchor.constraint(equalTo: formBuilderView.topAnchor),
            formBuilder.leadingAnchor.constraint(equalTo: formBuilderView.leadingAnchor),
            formBuilder.trailingAnchor.constraint(equalTo: formBuilderView.trailingAnchor),
            formBuilder.bottomAnchor.constraint(equalTo: formBuilderView.bottomAnchor),
            
            // Set width constraint to match the scroll view's width
            formBuilder.widthAnchor.constraint(equalTo: formBuilderView.widthAnchor)
        ])
    }
    
    private func populateForAdditionalInfo() -> [FormField] {
        [
            FormField(fieldType: .number,
                      placeholder: "establish_year".localized(),
                      name: "establish_year",
                      value: "\(String(describing: selectedSchool?.EstablishedYear ?? 0))",
                      isRequired: true),
            
            FormField(fieldType: .text,
                      placeholder: "location".localized(),
                      name: "location",
                      value: selectedSchool?.Location,
                      isRequired: true),
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDistrictsNames()),
                      placeholder: "district".localized(),
                      name: "district",
                      value: nil,
                      isRequired: true),
            
            FormField(fieldType: .number,
                      placeholder: "number_of_trained_teachers".localized(),
                      name: "number_of_trained_teachers",
                      value: "\(String(describing: selectedSchool?.NumOfTrainedTeachers ?? 0))",
                      isRequired: false),
            
            FormField(fieldType: .number,
                      placeholder: "available_seats_pwd".localized(),
                      name: "available_seats_pwd",
                      value: nil,
                      isRequired: false),
            
            FormField(fieldType: .dropdown(options: ["YES", "NO"]),
                      placeholder: "available_seats_pwd".localized(),
                      name: "available_seats_pwd",
                      value: "\(String(describing: selectedSchool?.NumberOfSeats ?? 0))",
                      isRequired: false),
            
            FormField(fieldType: .dropdown(options: ["YES", "NO"]),
                      placeholder: "trained_teachers".localized(),
                      name: "trained_teachers",
                      value: "\(String(describing: selectedSchool?.HasTrainingMaterial ?? false))",
                      isRequired: false),
            
            FormField(fieldType: .dropdown(options: ["YES", "NO"]),
                      placeholder: "accessibility_material".localized(),
                      name: "accessibility_material",
                      value: "\(String(describing: selectedSchool?.HasAccessibilityMaterial ?? false))",
                      isRequired: false),
            
            FormField(fieldType: .dropdown(options: ["YES", "NO"]),
                      placeholder: "trained_teachers".localized(),
                      name: "trained_teachers",
                      value: "\(String(describing: selectedSchool?.HasTrainingMaterial ?? false))",
                      isRequired: false),
            
            FormField(fieldType: .dropdown(options: ["Free", "Paid"]),
                      placeholder: "free_or_paid_education".localized(),
                      name: "free_or_paid_education",
                      value: "\(String(describing: selectedSchool?.FreeOrPaid ?? false))",
                      isRequired: false),
            
            FormField(fieldType: .number,
                      placeholder: "number_of_total_students".localized(),
                      name: "number_of_total_students",
                      value: "\(String(describing: selectedSchool?.NumberOfSeats ?? 0))",
                      isRequired: false),
        ]
    }
    
    private func populateForSchoolInfo() -> [FormField] {
        [
            FormField(fieldType: .text,
                      placeholder: "first_name".localized(),
                      name: "first_name",
                      value: UserSessionManager.shared.getUser().firstName,
                      isRequired: true),
            
            FormField(fieldType: .text,
                      placeholder: "last_name".localized(),
                      name: "last_name",
                      value: UserSessionManager.shared.getUser().lastName,
                      isRequired: true),
            
            FormField(fieldType: .text,
                      placeholder: "school_name".localized(),
                      name: "school_name",
                      value: selectedSchool?.SchoolName,
                      isRequired: true),
            
            FormField(fieldType: .email,
                      placeholder: "email".localized(),
                      name: "email",
                      value: selectedSchool?.EmailAddress,
                      isRequired: true),
            
            FormField(fieldType: .text,
                      placeholder: "ntn_number".localized(),
                      name: "ntn_number",
                      value: selectedSchool?.NTNNUmber,
                      isRequired: true),
            
            FormField(fieldType: .number,
                      placeholder: "contact_number".localized(),
                      name: "contact_number",
                      value: selectedSchool?.ContactNumber,
                      isRequired: true),
            
            FormField(fieldType: .text,
                      placeholder: "cnic".localized(),
                      name: "CNIC",
                      value: UserSessionManager.shared.getUser().cNIC,
                      isRequired: true),
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDesignations()),
                      placeholder: "designation".localized(),
                      name: "designation",
                      value: selectedSchool?.Designation,
                      isRequired: true),
        ]
    }
}

extension FormBuilderViewController {
    
    func setupNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        self.setBackButton(.textDark).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

extension FormBuilderViewController: FormBuilderProtocol {
    func submitForm(data: [String : Any]) {
        switch type {
        case .schoolInfo:
            
            guard let firstName = data["first_name"] as? String,
                  let lastName = data["last_name"] as? String,
                  let cnic = data["CNIC"] as? String,
                  let contact = data["contact_number"] as? String,
                  let schoolId = selectedSchool?.InstituteId,
                  let schoolName = data["school_name"] as? String,
                  let ntn = data["ntn_number"] as? String
            else { 
                SMM().showError(title: "Sorry", message: "Something Went Wrong")
                return }
            var user = User()
            user.firstName = firstName
            user.lastName = lastName
            user.cNIC = cnic
            user.contactNo = contact
            let creds = SchoolInfoCredentials(SchoolId: schoolId,
                                              SchoolName: schoolName,
                                              NTNNumber: ntn,
                                              oUser: user)
            updateSchoolInfo(creds: creds)
            
        case .general:
            break
        case .aboutYourSchool:
            guard let schoolId = selectedSchool?.InstituteId,
                  let about = data["about_your_school"] as? String
            else {
                SMM().showError(title: "Sorry", message: "Something Went Wrong")
                return }
            updateAboutSchool(creds: UpdateAboutYourSchoolCreds(SchoolId: schoolId,
                                                                AboutText: about))
        case .additionalInfo:
            break
        }
    }
}

struct SchoolInfoCredentials: Codable {
    let SchoolId: Int
    let SchoolName: String
    let NTNNumber: String
    let oUser: User
}

extension FormBuilderViewController {
    private func updateSchoolInfo(creds: SchoolInfoCredentials) {
        
        let request = Endpoint.updatePersonalInfo(creds: creds).request!
        showLoadingIndicator(withDimView: true)
        service.makeRequest(with: request,
                            respModel: ApiResponse<String>.self) {[weak self] userResponse, error in
            self?.hideLoadingIndicator()
            if let error = error { print("DEBUG PRINT:", error); return }
            print("DEBUG PRINT:", userResponse ?? "")
            
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong"); return }
            
            DispatchQueue.main.async {
                let storyboard = getStoryBoard(.main)
                let contentVC = storyboard.instantiateViewController(ofType: ThankYouViewController.self)
                contentVC.messageThankYou = .updateSchoolInfo
                contentVC.moveThankYou = .stay
                openModuleOverFullScreen(controller: contentVC)
            }
        }
    }
    
    private func updateAboutSchool(creds: UpdateAboutYourSchoolCreds) {
        let request = Endpoint.UpdateAboutYourSchool(creds: creds).request!
        showLoadingIndicator(withDimView: true)
        service.makeRequest(with: request,
                            respModel: ApiResponse<String>.self) {[weak self] userResponse, error in
            self?.hideLoadingIndicator()
            if let error = error { print("DEBUG PRINT:", error); return }
            print("DEBUG PRINT:", userResponse ?? "")
            
            if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong"); return }
            
            DispatchQueue.main.async {
                let storyboard = getStoryBoard(.main)
                let contentVC = storyboard.instantiateViewController(ofType: ThankYouViewController.self)
                contentVC.messageThankYou = .updateSchoolInfo
                contentVC.moveThankYou = .stay
                openModuleOverFullScreen(controller: contentVC)
            }
        }
    }
}
