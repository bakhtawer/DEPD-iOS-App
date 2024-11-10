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
        case denialOfJobComplainDetails
        case general
        case studentProfile
    }
    
    var type: FormType = .general
    
    var selectedSchool: InstituteModel?
    
    var denialOfAdmission: DenialOfAdmission? = nil
    var denialOfJob: DenialOfJob? = nil
    
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
            fields = populateCandidateDetailsJob()
        case .studentProfile:
            self.setTitle("update_profile".localized())
            labelTitle.text = "personal_details".localized()
            buttonTitle = "submit".localized()
            fields = populateStudentProfile()
        case .denialOfJobComplainDetails:
            self.setTitle("complain_details".localized())
            topTitleView.isHidden = true
            buttonTitle = "Submit".localized()
            fields = populateComplainDetails()
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
                               name: "father_name", value: USM.shared.getUser().oStudentDetails?.fatherName,
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
                      value: UserSessionManager.shared.getUser().cnic,
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
                      value: USM.shared.getUser().oStudentDetails?.fatherCnic,
                      isRequired: true),
            
            FormField(fieldType: .text,
                      placeholder: "email".localized(),
                      name: "email",
                      value: USM.shared.getUser().oStudentDetails?.emailAddress,
                      isRequired: true),
            
            FormField(fieldType: .dropdown(options: ["Male", "Female", "other"]),
                      placeholder: "gender".localized(),
                      name: "gender",
                      value: USM.shared.getUser().oStudentDetails?.gender,
                      isRequired: false),
            FormField(fieldType: .date, placeholder: "dob".localized(), name: "dob", value: USM.shared.getUser().oStudentDetails?.formattedDOB, isRequired: true),
            FormField(fieldType: .number, placeholder: "cnic".localized(), name: "cnic", value: USM.shared.getUser().cnic, isRequired: false, isEnabled: false),
            FormField(fieldType: .text, placeholder: "address".localized(), name: "address", value: USM.shared.getUser().oStudentDetails?.address, isRequired: false),
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDistrictsNames()),
                      placeholder: "district".localized(),
                      name: "district",
                      value: USM.shared.getUser().oStudentDetails?.district,
                      isRequired: false),
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDisabilitiesNames()),
                      placeholder: "disability".localized(),
                      name: "disability",
                      value: APPMetaDataHandler.shared.getDisabilities(byID: USM.shared.getUser().oStudentDetails?.disabilityStatusId ?? -1)?.name,
                      isRequired: false),
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getPreviousEducationName()),
                      placeholder: "previous_education".localized(),
                      name: "previous_education",
                      value: USM.shared.getUser().oStudentDetails?.previousEducation,
                      isRequired: false),
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            
            FormField(fieldType: .uploadFile, placeholder: "upload_picture", name: "upload_picture", value: nil, isRequired: false),
            FormField(fieldType: .uploadFile, placeholder: "disability_certificate", name: "disability_certificate", value: nil, isRequired: false),
            FormField(fieldType: .uploadFile, placeholder: "upload_form_b_certi", name: "upload_form_b_certi", value: nil, isRequired: false),
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
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
            user.cnic = cnic
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
            guard let dob = data["cdDob"] as? String else {
                SMM().showError(title: "Sorry", message: "Something Went Wrong with date of birth")
                return
            }
            let type: FormType
            if dob.isAbove18() {
                type = .denialOfAdmissionComplainDetails
            } else {
                type = .denialOfAdmissionParentDetails
            }
            //    Candidate Details
            denialOfAdmission?.cdName = data["cdName"] as? String
            denialOfAdmission?.cdGender = data["cdGender"] as? String
            denialOfAdmission?.cdCNIC = data["cdCNIC"] as? String
            denialOfAdmission?.cdDistrict = data["cdDistrict"] as? String
            denialOfAdmission?.cdFatherName = data["cdFatherName"] as? String
            denialOfAdmission?.cdDob = data["cdDob"] as? String
            denialOfAdmission?.cdContactNo = data["cdContactNo"] as? String
            denialOfAdmission?.cdDisability = data["cdDisability"] as? String
            denialOfAdmission?.cdPresentAddress = data["cdPresentAddress"] as? String
            
            print(denialOfAdmission)
            
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.denialOfAdmission = self?.denialOfAdmission
                view.type = type
                openModuleOnNavigation(from: self, controller: view)
            }
        case .denialOfAdmissionComplainDetails:
            //    Complain Details
            denialOfAdmission?.complainDetailsInstituteName = data["complainDetailsInstituteName"] as? String
            denialOfAdmission?.complainDetailsInstituteEmailAddress = data["complainDetailsInstituteEmailAddress"] as? String
            denialOfAdmission?.complainDetailsDistrict = data["complainDetailsDistrict"] as? String
            denialOfAdmission?.complainDetailsReasonOfDenialOfAdmission = data["complainDetailsReasonOfDenialOfAdmission"] as? String
            denialOfAdmission?.complainDetailsInstituteContactNumber = data["complainDetailsInstituteContactNumber"] as? String
            denialOfAdmission?.complainDetailsInstituteAddress = data["complainDetailsInstituteAddress"] as? String
            denialOfAdmission?.complainDetailsPresentAddress = data["complainDetailsPresentAddress"] as? String
            denialOfAdmission?.complainDetailsCheckBox = data["complainDetailsCheckBox"] as? Bool
            
            print(denialOfAdmission)
            guard let complainDetailsCheckBox = data["complainDetailsCheckBox"] as? String,
                  complainDetailsCheckBox.makeItBool else {
                SMM().showError(title: "Sorry", message: "Please select the checkbox")
                return
            }
            
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let contentVC = storyboard.instantiateViewController(ofType: ThankYouViewController.self)
                contentVC.messageThankYou = .denialOfAdmission
                contentVC.moveThankYou = .splash
                openModuleOverFullScreen(controller: contentVC)
            }
        case .denialOfAdmissionParentDetails:
            //    Parent/Guardian Details
            denialOfAdmission?.pdName = data["pdName"] as? String
            denialOfAdmission?.pdCNIC = data["pdCNIC"] as? String
            denialOfAdmission?.pdEmail = data["pdEmail"] as? String
            denialOfAdmission?.pdRelationWithCandidate = data["pdRelationWithCandidate"] as? String
            denialOfAdmission?.pdContactNo = data["pdContactNo"] as? String
            
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.denialOfAdmission = self?.denialOfAdmission
                view.type = .denialOfAdmissionComplainDetails
                openModuleOnNavigation(from: self, controller: view)
            }
        case .denialOfJob:
            
            let dob = data["cdDob"] as? String
            denialOfJob?.cdName = data["cdName"] as? String
            denialOfJob?.cdGender = data["cdGender"] as? String
            denialOfJob?.cdCNIC = data["cdCNIC"] as? String
            denialOfJob?.cdDistrict = data["cdDistrict"] as? String
            denialOfJob?.cdFatherName = data["cdFatherName"] as? String
            denialOfJob?.cdDob = dob?.toFormattedDate()
            denialOfJob?.cdContactNo = data["cdContactNo"] as? String
            denialOfJob?.cdDisability = data["cdDisability"] as? String
            denialOfJob?.cdPresentAddress = data["cdPresentAddress"] as? String
            
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.denialOfJob = self?.denialOfJob
                view.type = .denialOfJobComplainDetails
                openModuleOnNavigation(from: self, controller: view)
            }
        case .studentProfile:
            break
        case .denialOfJobComplainDetails:
            
            guard let complainDetailsCheckBox = data["complainDetailsCheckBox"] as? String,
                  complainDetailsCheckBox.makeItBool else {
                SMM().showError(title: "Sorry", message: "Please select the checkbox")
                return
            }
            
            denialOfJob?.complainDetailsCompanyName = data["complainDetailsCompanyName"] as? String
            denialOfJob?.complainDetailsCompanyEmailAddress = data["complainDetailsCompanyEmailAddress"] as? String
            denialOfJob?.complainDetailsCompanyString = data["complainDetailsCompanyString"] as? String
            denialOfJob?.complainDetailsReasonOfDenialOfJob = data["complainDetailsReasonOfDenialOfJob"] as? String
            denialOfJob?.complainDetailsCompanyContactNumber = data["complainDetailsCompanyContactNumber"] as? String
            denialOfJob?.complainDetailsPresentAddress = data["complainDetailsPresentAddress"] as? String
            denialOfJob?.complainDetailsDistrict = data["complainDetailsDistrict"] as? String
            denialOfJob?.complainDetailsCheckBox = complainDetailsCheckBox.makeItBool
            
            print(denialOfJob)
            
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let contentVC = storyboard.instantiateViewController(ofType: ThankYouViewController.self)
                contentVC.messageThankYou = .denialOfJob
                contentVC.moveThankYou = .splash
                openModuleOverFullScreen(controller: contentVC)
            }
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
