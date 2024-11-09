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
    case recordYourMessage
    case uploadFile
    case checkbox
    case gap
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
    var isEnabled: Bool = true
}

protocol FormBuilderProtocol: AnyObject {
    func submitForm(data:  [String: Any])
}

class FormBuilderViewController: BaseViewController {
    
    @IBOutlet weak var topTitleView: UIView!
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
        case denialOfAdmission
        case denialOfAdmissionComplainDetails
        case denialOfAdmissionParentDetails
        case denialOfJob
        case general
        case studentProfile
    }
    
    var type: FormType = .general
    
    var selectedSchool: InstituteModel?
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        labelTitle.makeItTheme(.bold, 16)
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
    }
    
    private func setUpView() {
        let fields: [FormField]
        
        var buttonTitle = "register_submit".localized()
        
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
            
        case .denialOfAdmission:
            self.setTitle("candidate_details".localized())
            labelTitle.text = "" //"".localized()
            topTitleView.isHidden = true
            
            buttonTitle = "next".localized()
            
            fields = populateCandidateDetails()
            
        case .denialOfAdmissionComplainDetails:
            self.setTitle("complain_details".localized())
            topTitleView.isHidden = true
            
            buttonTitle = "Submit".localized()
            
            fields = populateComplainDetailsAdmission()
            
        case .denialOfAdmissionParentDetails:
            self.setTitle("parent_details".localized())
            labelTitle.text = "if_the_complainant".localized()
            
            buttonTitle = "next".localized()
            
            fields = populateParentsDetails()
        case .denialOfJob:
            self.setTitle("candidate_details".localized())
            labelTitle.text = "" //"".localized()
            topTitleView.isHidden = true
            buttonTitle = "next".localized()
            fields = populateCandidateDetails()
        case .studentProfile:
            self.setTitle("update_profile".localized())
            labelTitle.text = "personal_information".localized()
            buttonTitle = "submit".localized()
            fields = populateStudentProfile()
        }
        
        let formBuilder = FormBuilderView(fields: fields, buttonTitle)
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
    
    private func populateComplainDetailsAdmission() -> [FormField] {
        [
            
//            Institute Name
//            Institute Email Address
//            District
//            select
//            Reason of Denial of Addmission
            
            FormField(fieldType: .text, placeholder: "institute_name".localized(), name: "institute_name",
                      value: nil, isRequired: false),
            
            FormField(fieldType: .text, placeholder: "institute_email".localized(), name: "institute_email",
                      value: nil, isRequired: false),
            
            FormField(fieldType: .email, placeholder: "institute_contact_no".localized(), name: "institute_contact_no",
                      value: nil, isRequired: false),
            
            FormField(fieldType: .text, placeholder: "present_address".localized(), name: "present_address_institute",
                      value: nil, isRequired: false),
            
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDistrictsNames()),
                      placeholder: "district".localized(),
                      name: "district_institute",
                      value: nil,
                      isRequired: false),
            
            FormField(fieldType: .textLong, placeholder: "reason_of_denial_of_admission".localized(), name: "reason_of_denial_of_admission", value: nil, isRequired: false),
            
            FormField(fieldType: .recordYourMessage, placeholder: "record_your_message".localized(), name: "record_your_message", value: nil, isRequired: false),
            
            FormField(fieldType: .uploadFile, placeholder: "upload_related_documents".localized(), name: "upload_related_documents_addmission", value: nil, isRequired: false),
            
            FormField(fieldType: .checkbox, placeholder: "i_herby_that".localized(), name: "checkbox", value: nil, isRequired: false),
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
        ]
    }
    
    private func populateComplainDetails() -> [FormField] {
        [
            
            FormField(fieldType: .text, placeholder: "company_name".localized(), name: "company_name",
                      value: nil, isRequired: false),
            
            FormField(fieldType: .text, placeholder: "company_contact_number".localized(), name: "company_contact_number",
                      value: nil, isRequired: false),
            
            FormField(fieldType: .email, placeholder: "company_email_address".localized(), name: "company_email_address",
                      value: nil, isRequired: false),
            
            FormField(fieldType: .text, placeholder: "present_address_company".localized(), name: "present_address_company",
                      value: nil, isRequired: false),
            
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDistrictsNames()),
                      placeholder: "district".localized(),
                      name: "district_company",
                      value: nil,
                      isRequired: false),
            
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            
            FormField(fieldType: .textLong, placeholder: "reason_of_denial_of_admission", name: "reason_of_denial_of_admission", value: nil, isRequired: false),
            
            FormField(fieldType: .recordYourMessage, placeholder: "record_your_message".localized(), name: "record_your_message", value: nil, isRequired: false),
            
            FormField(fieldType: .uploadFile, placeholder: "upload_file".localized(), name: "upload_file", value: nil, isRequired: false),
            
            FormField(fieldType: .checkbox, placeholder: "i_herby_that".localized(), name: "checkbox", value: nil, isRequired: false)
        ]
    }
    
    private func populateParentsDetails() -> [FormField] {
        [
            FormField(fieldType: .text, placeholder: "full_name".localized(), name: "full_name",
                      value: nil, isRequired: false),
            
            FormField(fieldType: .number, placeholder: "cnic".localized(), name: "cnic", value: nil, isRequired: false),
            
            FormField(fieldType: .number, placeholder: "contact_no".localized(), name: "contact_no", value: nil, isRequired: false),
            
            FormField(fieldType: .email, placeholder: "email".localized(), name: "email", value: nil, isRequired: false),
            
            FormField(fieldType: .dropdown(options: ["Father", "Mother", "Guardian"]),
                      placeholder: "relation_with_cadidate".localized(),
                      name: "relation_with_cadidate",
                      value: nil,
                      isRequired: false),
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false)
        ]
    }
    
    private func populateCandidateDetails() -> [FormField] {
        [
            FormField(fieldType: .text, placeholder: "full_name".localized(), name: "fullname",
                      value: nil, isRequired: false),
            
            FormField(fieldType: .text, placeholder: "father_name".localized(), name: "father_name", value: nil, isRequired: false),
            
            FormField(fieldType: .dropdown(options: ["Male", "Female", "other"]),
                      placeholder: "gender".localized(),
                      name: "gender",
                      value: nil,
                      isRequired: false),
            
            FormField(fieldType: .date, placeholder: "dob".localized(), name: "dob", value: nil, isRequired: true),
            
            FormField(fieldType: .number, placeholder: "cnic".localized(), name: "cnic", value: nil, isRequired: false),
            
            FormField(fieldType: .number, placeholder: "contact_no".localized(), name: "contact_no", value: nil, isRequired: false),
            
            FormField(fieldType: .text, placeholder: "present_address".localized(), name: "present_address", value: nil, isRequired: false),
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDistrictsNames()),
                      placeholder: "district".localized(),
                      name: "district",
                      value: nil,
                      isRequired: false),
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDisabilitiesNames()),
                      placeholder: "disability".localized(),
                      name: "disability",
                      value: nil,
                      isRequired: false),
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false)
        ]
        
    }
    
    private func populateForAdditionalInfo() -> [FormField] {
        [
            FormField(fieldType: .number,
                      placeholder: "establish_year".localized(),
                      name: "establish_year",
                      value: "\(String(describing: selectedSchool?.EstablishedYear ?? 0))",
                      isRequired: false),
            
            FormField(fieldType: .text,
                      placeholder: "location".localized(),
                      name: "location",
                      value: selectedSchool?.Location,
                      isRequired: false),
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDistrictsNames()),
                      placeholder: "district".localized(),
                      name: "district",
                      value: nil,
                      isRequired: false),
            
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
                      value: "\(String(describing: selectedSchool?.FreeOrPaid ?? 0))",
                      isRequired: false),
            
            FormField(fieldType: .number,
                      placeholder: "number_of_total_students".localized(),
                      name: "number_of_total_students",
                      value: "\(String(describing: selectedSchool?.NumberOfSeats ?? 0))",
                      isRequired: false),
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false)
        ]
    }
   let firstName =  FormField(fieldType: .text,
                              placeholder: "first_name".localized(),
                              name: "first_name",
                              value: USM.shared.getUser().firstName,
                              isRequired: true)
    
    let lastName =  FormField(fieldType: .text,
                               placeholder: "last_name".localized(),
                               name: "last_name",
                              value: USM.shared.getUser().lastName,
                               isRequired: true)
    
    let fatherName = FormField(fieldType: .text,
                               placeholder: "father_name".localized(),
                               name: "father_name", value: nil,
                               isRequired: false)
    
    private func populateForSchoolInfo() -> [FormField] {
        [
            firstName,
            lastName,
            
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
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
        ]
    }
    
    private func populateStudentProfile() -> [FormField] {
        [
            firstName,
            lastName,
            fatherName,
            FormField(fieldType: .text,
                      placeholder: "father_cnic".localized(),
                      name: "father_cnic",
                      value: nil,
                      isRequired: true),
            
            FormField(fieldType: .text,
                      placeholder: "email".localized(),
                      name: "email",
                      value: USM.shared.getUser().emailAddress,
                      isRequired: true),
            
            FormField(fieldType: .dropdown(options: ["Male", "Female", "other"]),
                      placeholder: "gender".localized(),
                      name: "gender",
                      value: nil,
                      isRequired: false),
            FormField(fieldType: .date, placeholder: "dob".localized(), name: "dob", value: nil, isRequired: true),
            FormField(fieldType: .number, placeholder: "cnic".localized(), name: "cnic", value: USM.shared.getUser().cNIC, isRequired: false, isEnabled: false),
            FormField(fieldType: .text, placeholder: "address".localized(), name: "address", value: nil, isRequired: false),
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDistrictsNames()),
                      placeholder: "district".localized(),
                      name: "district",
                      value: nil,
                      isRequired: false),
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDisabilitiesNames()),
                      placeholder: "disability".localized(),
                      name: "disability",
                      value: nil,
                      isRequired: false),
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getPreviousEducationName()),
                      placeholder: "previous_education".localized(),
                      name: "previous_education",
                      value: nil,
                      isRequired: false),
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            
            FormField(fieldType: .uploadFile, placeholder: "upload_picture", name: "upload_picture", value: nil, isRequired: false),
            FormField(fieldType: .uploadFile, placeholder: "disability_certificate", name: "disability_certificate", value: nil, isRequired: false),
            FormField(fieldType: .uploadFile, placeholder: "upload_form_b_certi", name: "upload_form_b_certi", value: nil, isRequired: false),
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
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
        case .denialOfAdmission:
            guard let dob = data["dob"] as? String else {
                SMM().showError(title: "Sorry", message: "Something Went Wrong")
                return
            }
            let type: FormType
            if dob.isAbove18() {
                type = .denialOfAdmissionComplainDetails
            } else {
                type = .denialOfAdmissionParentDetails
            }
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = type
                openModuleOnNavigation(from: self, controller: view)
            }
        case .denialOfAdmissionComplainDetails:
            break
        case .denialOfAdmissionParentDetails:
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .denialOfAdmissionComplainDetails
                openModuleOnNavigation(from: self, controller: view)
            }
        case .denialOfJob:
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .denialOfAdmissionComplainDetails
                openModuleOnNavigation(from: self, controller: view)
            }
        case .studentProfile:
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
