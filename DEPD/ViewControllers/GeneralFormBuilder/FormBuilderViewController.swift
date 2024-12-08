//
//  FormBuilderViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 28/09/2024.
//

import UIKit
import Kingfisher

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
    case uploadedFile
    case dateFrom
    case dateTo
    case gapTop
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
    var image: UIImage?
}

protocol FormBuilderProtocol: AnyObject {
    func submitForm(data:  [String: Any])
    func getImageFor(name: String)
}

class FormBuilderViewController: BaseViewController {
    
    @IBOutlet weak var topTitleView: UIView!
    @IBOutlet weak var formBuilderView: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    
    let service = APIService()
    
    var selectImageName = ""
    var selectedImageString = ""
    
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
        case acceptStudentAdmission
        case rejectStudentAdmission
        
        case schoolSocialMultiMedia
        case schoolSocialMedia
        case schoolWeCanEducate
        
        case personalInformation
        case education
        case workExperience
        case technicalSkills
        case aboutMyself
        case jobAdditionalInfo
        case certification
        
        case acceptJobApplication
        case rejectJobApplication
        
        case personalInformationEmployer
        case socialMediaEmployer
        case weProvideJobEmployer
        case accessibilityMaterialEmployer
    }
    
    var type: FormType = .general
    
    var selectedSchool: InstituteModel?
    
    var denialOfAdmission: DenialOfAdmission? = nil
    var denialOfJob: DenialOfJob? = nil
    
    var studentDetails: StudentDetails? = nil
    
    var studentAdmissionId: Int?
    
    var studentPP = ""
    var disabilityCer = ""
    
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
                          value: USM.shared.getUser().schoolDetailInfo?.aboutText,
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
        case .acceptStudentAdmission:
            self.setTitle("")
            labelTitle.text = "student_admission".localized()
            buttonTitle = "Submit".localized()
            fields = [
                FormField(fieldType: .gapTop, placeholder: "", name: "", value: nil, isRequired: false),
                FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getClassesName()),
                          placeholder: "select_class".localized(),
                          name: "select_class",
                          value: nil,
                          isRequired: true),
                FormField(fieldType: .number, placeholder: "enter_fee".localized(), name: "enter_fee", value: nil, isRequired: true),
                FormField(fieldType: .uploadFile, placeholder: "upload_slip".localized(), name: "upload_slip", value: nil, isRequired: false),
                FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
                FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
                FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
                FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            ]
        case .rejectStudentAdmission:
            self.setTitle("")
            labelTitle.text = "student_admission".localized()
            buttonTitle = "Submit".localized()
            fields = [
                FormField(fieldType: .textLong, placeholder: "enter_reason".localized(), name: "enter_reason", value: nil, isRequired: true),
                FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
                FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
                FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
                FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            ]
        case .schoolSocialMultiMedia:
            self.setTitle("update_profile".localized())
            labelTitle.text = "school_multi_media".localized()
            buttonTitle = "Submit".localized()
            fields = [
                FormField(fieldType: .uploadFile, placeholder: "upload_picture".localized(), name: "upload_picture", value: nil, isRequired: true),
                FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
                FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
                FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
                FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            ]
        case .schoolSocialMedia:
            self.setTitle("update_profile".localized())
            labelTitle.text = "socail_media_links".localized()
            buttonTitle = "Submit".localized()
            fields = [
                FormField(fieldType: .gapTop, placeholder: "", name: "", value: nil, isRequired: false),
                FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getSocialMediaListName()),
                          placeholder: "account_type".localized(),
                          name: "account_type",
                          value: nil,
                          isRequired: false),
                FormField(fieldType: .text, placeholder: "link".localized(), name: "link", value: nil, isRequired: true),
                FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
                FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
                FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            ]
        case .schoolWeCanEducate:
            self.setTitle("update_profile".localized())
            labelTitle.text = "we_can_educate".localized()
            buttonTitle = "Submit".localized()
            fields = [
                FormField(fieldType: .gapTop, placeholder: "", name: "", value: nil, isRequired: false),
                FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDisabilitiesNames()),
                          placeholder: "disability".localized(),
                          name: "we_can_educate",
                          value: nil,
                          isRequired: false),
                FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
                FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
                FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
                FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            ]
        case .personalInformation:
            self.setTitle("update_profile".localized())
            labelTitle.text = "personal_information".localized()
            buttonTitle = "Submit".localized()
            fields = populateJobSeekerPersonalInfo()
        case .education:
            self.setTitle("update_profile".localized())
            labelTitle.text = "education".localized()
            buttonTitle = "Submit".localized()
            fields = populateJobSeekerEducation()
        case .workExperience:
            self.setTitle("update_profile".localized())
            labelTitle.text = "work_experience".localized()
            buttonTitle = "Submit".localized()
            fields = populateJobSeekerWorkExperience()
        case .technicalSkills:
            self.setTitle("update_profile".localized())
            labelTitle.text = "technical_skills".localized()
            buttonTitle = "Submit".localized()
            fields = populateJobSeekerTechnicalSkills()
        case .aboutMyself:
            self.setTitle("update_profile".localized())
            labelTitle.text = "about_myself".localized()
            buttonTitle = "Submit".localized()
            fields = populateJobSeekerAboutMySelf()
        case .jobAdditionalInfo:
            self.setTitle("update_profile".localized())
            labelTitle.text = "additional_info".localized()
            buttonTitle = "Submit".localized()
            fields = populateJobSeekerAdditionalInfo()
        case .certification:
            self.setTitle("update_profile".localized())
            labelTitle.text = "certification".localized()
            buttonTitle = "Submit".localized()
            fields = populateJobSeekerCertification()
        case .acceptJobApplication:
            self.setTitle("".localized())
            labelTitle.text = "confirm_hiring".localized()
            buttonTitle = "Submit".localized()
            fields = populateJobAcceptApplication()
        case .rejectJobApplication:
            self.setTitle("".localized())
            labelTitle.text = "confirm_hiring".localized()
            buttonTitle = "Submit".localized()
            fields = populateJobRejectApplication()
        case .personalInformationEmployer:
            self.setTitle("update_profile".localized())
            labelTitle.text = "personal_information".localized()
            buttonTitle = "Submit".localized()
            fields = populatePersonalInformationEmployer()
        case .socialMediaEmployer:
            self.setTitle("update_profile".localized())
            labelTitle.text = "social_media_links".localized()
            buttonTitle = "Submit".localized()
            fields = populateSocialMediaEmployer()
        case .weProvideJobEmployer:
            self.setTitle("update_profile".localized())
            labelTitle.text = "we_provide_job_for".localized()
            buttonTitle = "Submit".localized()
            fields = populateWeProvideJobEmployer()
        case .accessibilityMaterialEmployer:
            self.setTitle("update_profile".localized())
            labelTitle.text = "accessibility_material".localized()
            buttonTitle = "Submit".localized()
            fields = populateAccessibilityMaterialEmplor()
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
                      value: SchoolManager.shared.selectedSchool?.SchoolName,
                      isRequired: true),
            
            FormField(fieldType: .email,
                      placeholder: "email".localized(),
                      name: "email",
                      value: USM.shared.getUser().schoolDetailInfo?.emailAddress,
                      isRequired: true),
            
            FormField(fieldType: .text,
                      placeholder: "ntn_number".localized(),
                      name: "ntn_number",
                      value: USM.shared.getUser().schoolDetailInfo?.ntnNumber,
                      isRequired: true),
            
            FormField(fieldType: .number,
                      placeholder: "contact_number".localized(),
                      name: "contact_number",
                      value: USM.shared.getUser().contactNo,
                      isRequired: true),
            
            FormField(fieldType: .text,
                      placeholder: "cnic".localized(),
                      name: "CNIC",
                      value: UserSessionManager.shared.getUser().cnic,
                      isRequired: true, isEnabled: false),
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDesignations()),
                      placeholder: "designation".localized(),
                      name: "designation",
                      value: USM.shared.getUser().schoolDetailInfo?.designation,
                      isRequired: true),
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
        ]
    }
    
    private func populateStudentProfile() -> [FormField] {
        
        var fields = [
            firstName,
            lastName,
            fatherName,
            FormField(fieldType: .text,
                      placeholder: "father_cnic".localized(),
                      name: "father_cnic",
                      value: studentDetails?.fatherCnic,
                      isRequired: true),
            
            FormField(fieldType: .text,
                      placeholder: "email".localized(),
                      name: "email",
                      value: USM.shared.getUser().oStudentDetails?.emailAddress,
                      isRequired: true),
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getGendersName()),
                      placeholder: "gender".localized(),
                      name: "gender",
                      value: "\(String(describing: AMDH.shared.getGenders(byID: USM.shared.getUser().oStudentDetails?.genderId ?? -1)?.name ?? ""))",
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
        ]
        
        if let profileUrl = USM.shared.getUser().oStudentDetails?.profilePictureURL, !profileUrl.isEmpty {
            fields.append(FormField(fieldType: .uploadedFile, placeholder: "upload_profile_picture".localized(), name: "upload_profile_picture", value: profileUrl.convertToHttps(), isRequired: false))
            let imageView = UIImageView()
            imageView.kf.setImage(with: URL(string: profileUrl.convertToHttps())) {[weak self] result in
               switch result {
               case .success(let value):
                   self?.studentPP = self?.imageToByteString(image: value.image, true) ?? ""
                   print("profile_picture Image: \(value.image). Got from: \(value.cacheType)")
               case .failure(let error):
                   print("Error: \(error)")
               }
             }
        }else {
            fields.append(FormField(fieldType: .uploadFile, placeholder: "upload_profile_picture".localized(), name: "upload_profile_picture", value: nil, isRequired: false))
        }
        
//        fields.append(FormField(fieldType: .uploadFile, placeholder: "upload_form_b_cnic".localized(), name: "upload_form_b_cnic", value: nil, isRequired: false))
        
        if let disabilityCertificate = USM.shared.getUser().oStudentDetails?.disabilityCertificateURL, !disabilityCertificate.isEmpty {
            fields.append(FormField(fieldType: .uploadedFile, placeholder: "upload_disability_certificate".localized(), name: "upload_disability_certificate", value: disabilityCertificate.convertToHttps(), isRequired: false))
            let imageView = UIImageView()
            imageView.kf.setImage(with: URL(string: disabilityCertificate.convertToHttps())) {[weak self] result in
               switch result {
               case .success(let value):
                   self?.disabilityCer = self?.imageToByteString(image: value.image, true) ?? ""
                   print("disabilityCer Image: \(value.image). Got from: \(value.cacheType)")
               case .failure(let error):
                   print("Error: \(error)")
               }
             }
        }else {
            fields.append(FormField(fieldType: .uploadFile, placeholder: "upload_disability_certificate".localized(), name: "upload_disability_certificate", value: nil, isRequired: false))
        }
        
        fields.append(FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false))
        return fields
    }
    
    private func populateForAdditionalInfo() -> [FormField] {
        [
            FormField(fieldType: .number,
                      placeholder: "establish_year".localized(),
                      name: "establish_year",
                      value: "\(String(describing: SchoolManager.shared.selectedSchool?.EstablishedYear ?? 0))",
                      isRequired: false),
            
            FormField(fieldType: .text,
                      placeholder: "location".localized(),
                      name: "location",
                      value: SchoolManager.shared.selectedSchool?.Location,
                      isRequired: false),
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDistrictsNames()),
                      placeholder: "district".localized(),
                      name: "district",
                      value: USM.shared.getUser().schoolDetailInfo?.district,
                      isRequired: false),
            
            FormField(fieldType: .number,
                      placeholder: "trained_teachers".localized(),
                      name: "trained_teachers",
                      value: "\(String(describing: SchoolManager.shared.selectedSchool?.NumOfTrainedTeachers ?? 0))",
                      isRequired: false),
            
            FormField(fieldType: .dropdown(options: ["YES", "NO"]),
                      placeholder: "accessibility_material".localized(),
                      name: "accessibility_material",
                      value: "\(APPMetaDataHandler.shared.getYesNoFromInt(value: SchoolManager.shared.selectedSchool?.HasAccessibilityMaterial?.makeItInt ?? 0))",
                      isRequired: false),
            
            FormField(fieldType: .dropdown(options: ["YES", "NO"]),
                      placeholder: "trained_teachers".localized(),
                      name: "trained_teachers",
                      value: "\(APPMetaDataHandler.shared.getYesNoFromInt(value: SchoolManager.shared.selectedSchool?.HasTrainingMaterial?.makeItInt ?? 0))",
                      isRequired: false),
            
            FormField(fieldType: .dropdown(options: ["Free", "Paid"]),
                      placeholder: "free_or_paid_education".localized(),
                      name: "free_or_paid_education",
                      value: "\(APPMetaDataHandler.shared.getFreePaidFromInt(value: SchoolManager.shared.selectedSchool?.FreeOrPaid ?? 0))",
                      isRequired: false),
            
            FormField(fieldType: .number,
                      placeholder: "number_of_total_students".localized(),
                      name: "number_of_total_students",
                      value: "\(String(describing: SchoolManager.shared.selectedSchool?.NumberOfSeats ?? 0))",
                      isRequired: false),
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false)
        ]
    }
}

extension FormBuilderViewController {
    func setupNavigation() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.setNavBarColor(.appBG)
        self.setBackButton(.textDark).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

extension FormBuilderViewController: FormBuilderProtocol {
    func getImageFor(name: String) {
        selectImageName = name
        presentActionSheet()
    }
    
    func submitForm(data: [String : Any]) {
        switch type {
        case .schoolInfo:
            
            guard let firstName = data["first_name"] as? String,
                  let lastName = data["last_name"] as? String,
                  let cnic = data["CNIC"] as? String,
                  let contact = data["contact_number"] as? String,
                  let schoolId = USM.shared.getUser().schoolDetailInfo?.id,
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
            guard let schoolId = SchoolManager.shared.selectedSchool?.InstituteId,
                  let about = data["about_your_school"] as? String
            else {
                SMM().showError(title: "Sorry", message: "Something Went Wrong")
                return }
            updateAboutSchool(creds: UpdateAboutYourSchoolCreds(SchoolId: schoolId,
                                                                AboutText: about))
        case .additionalInfo:
            let establish_year = data["establish_year"] as? String ?? ""
            let location = data["location"] as? String ?? ""
            let district = data["district"] as? String ?? ""
            let number_of_trained_teachers = data["number_of_trained_teachers"] as? String
            let trained_teachers = data["trained_teachers"] as? String
            let accessibility_material = data["accessibility_material"] as? String
            let free_or_paid_education = data["free_or_paid_education"] as? String
            let number_of_total_students = data["number_of_total_students"] as? String
            
            guard let schoolId = SchoolManager.shared.selectedSchool?.InstituteId,
                  let number_of_total_studentsInt = Int(number_of_total_students ?? "0"),
                  let trained_teachersInt = Int(number_of_trained_teachers ?? "0")
            else {
                SMM().showError(title: "Sorry", message: "Something Went Wrong")
                return }
            
            var free_or_paid_educationInt = 0
            if free_or_paid_education == "Free" {
                free_or_paid_educationInt = 1
            }else {
                free_or_paid_educationInt = 2
            }
            
            var accessibility_materialInt = 0
            if accessibility_material == "Yes" {
                accessibility_materialInt = 1
            }
          
             let info = UpdateAdditionalInfoCreds(SchoolId: schoolId,
                                                  EstablishedYear: establish_year,
                                                  Location: location,
                                                  District: district,
                                                  NumberOfTrainedTeachers: trained_teachersInt,
                                                  HasTrainingMaterial: accessibility_materialInt,
                                                  NumberOfTotalStudents: number_of_total_studentsInt,
                                                  CanEducate: 1,
                                                  FreeOrPaid: free_or_paid_educationInt)
            
            SchoolManager.shared.updateAdditionalInfo(data: info) {[weak self] status in
                
                SchoolManager.shared.fetchAllSchoolsForSchool {[weak self] status in
                    self?.hideLoadingIndicator()
                    if status { DispatchQueue.main.async {[weak self] in self?.navigationController?.popViewController(animated: true) } }
                }
            }
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
            let firstName = data["first_name"] as? String ?? ""
            let lastName = data["last_name"] as? String ?? ""
//            studentDetails = data["first_name"] as? String
//            studentDetails = data["last_name"] as? String
            studentDetails?.fatherName = data["father_name"] as? String
            studentDetails?.fatherCnic = data["father_cnic"] as? String
            studentDetails?.emailAddress = data["email"] as? String
            studentDetails?.gender = data["gender"] as? String
            studentDetails?.dob = (data["dob"] as? String)?.toFormattedDate()
            
            studentDetails?.address = data["address"] as? String
            studentDetails?.district = data["district"] as? String
            let disability = (data["disability"] as? String) ?? ""
            studentDetails?.disabilityStatusId = APPMetaDataHandler.shared.getDisabilities(byName: disability)?.disabilityId
            studentDetails?.previousEducation = data["previous_education"] as? String
            
            let genderID = APPMetaDataHandler.shared.getGenders(byName: studentDetails?.gender ?? "")?.genderId
            
            if let hasPPUploaded = studentDetails?.hasPPUploaded, !hasPPUploaded, !studentPP.isEmpty {
                studentDetails?.profilePictureString = studentPP
                studentDetails?.profilePictureName = "\(UUID().uuidString).jpg"
                studentDetails?.hasPPUploaded = true
            }
            
            if let hasDisCertUploaded = studentDetails?.hasDisCertUploaded, !hasDisCertUploaded, !disabilityCer.isEmpty {
                studentDetails?.disabilityCertificateString = disabilityCer
                studentDetails?.disabilityCertName = "\(UUID().uuidString).jpg"
                studentDetails?.hasDisCertUploaded = true
            }
            
            let student = StudentUpdateDetails(Id: USM.shared.getUser().oStudentDetails?.studentId ?? -1,
                                               FirstName: firstName,
                                               LastName: lastName,
                                               ContactNo: USM.shared.getUser().contactNo,
                                               oStudentDetails: StudentUpdateDetails.StudentDetails(
                                                FatherName: studentDetails?.fatherName,
                                                FatherCNIC: studentDetails?.fatherCnic,
                                                DisabilityStatusId: studentDetails?.disabilityStatusId,
                                                ProfilePictureURL: studentDetails?.profilePictureURL,
                                                DisabilityCertificateURL: studentDetails?.disabilityCertificateURL,
                                                ProfilePictureBytesString: studentDetails?.profilePictureString,
                                                ProfilePictureName: studentDetails?.profilePictureName,
                                                DisabilityCertBytesString: studentDetails?.disabilityCertificateString,
                                                DisabilityCertName: studentDetails?.disabilityCertName,
                                                Address: studentDetails?.address,
                                                District: studentDetails?.district,
                                                DOB: studentDetails?.dob,
                                                PreviousEducation: studentDetails?.previousEducation,
                                                GenderId: genderID))
            self.showLoadingIndicator(withDimView: true)
            USM.shared.update(student: student) { [weak self] status in
                self?.hideLoadingIndicator()
                if status {
                    DispatchQueue.main.async {[weak self] in
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            }
            
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
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let contentVC = storyboard.instantiateViewController(ofType: ThankYouViewController.self)
                contentVC.messageThankYou = .denialOfJob
                contentVC.moveThankYou = .splash
                openModuleOverFullScreen(controller: contentVC)
            }
        case .acceptStudentAdmission:
            guard let selectedClass = data["select_class"] as? String,
                  let selectedFees = data["enter_fee"] as? String,
                  let studentAdmissionId = studentAdmissionId
            else { return }
            let data = StudentAdmissionUpdateCred(Id: studentAdmissionId,
                                                  AdmissionStatusId: 1,
                                                  Class: selectedClass,
                                                  Fees: selectedFees,
                                                  Reason: nil,
                                                  SlipByte: selectedImageString,
                                                  SlipName: "\(UUID().uuidString).jpg")
            self.showLoadingIndicator(withDimView: true)
            SchoolManager.shared.studentAdmissionUpdate(data: data) {[weak self] status in
                SchoolManager.shared.fetchAllSchoolsForSchool {[weak self] status in
                    self?.hideLoadingIndicator()
                    if status { DispatchQueue.main.async {[weak self] in self?.navigationController?.popViewController(animated: true) } }
                }
            }
        case .rejectStudentAdmission:
            guard let reason = data["enter_reason"] as? String,
                  let studentAdmissionId = studentAdmissionId
            else { return }
            let data = StudentAdmissionUpdateCred(Id: studentAdmissionId,
                                                  AdmissionStatusId: 3,
                                                  Class: nil,
                                                  Fees: nil,
                                                  Reason: reason,
                                                  SlipByte: nil,
                                                  SlipName: nil)
            self.showLoadingIndicator(withDimView: true)
            SchoolManager.shared.studentAdmissionUpdate(data: data) {[weak self] status in
                SchoolManager.shared.fetchAllSchoolsForSchool {[weak self] status in
                    self?.hideLoadingIndicator()
                    if status { DispatchQueue.main.async {[weak self] in self?.navigationController?.popViewController(animated: true) } }
                }
            }
        case .schoolSocialMultiMedia:
            guard !selectedImageString.isEmpty,
                  let schoolID = SchoolManager.shared.selectedSchool?.InstituteId,
                  schoolID != -1,
                  let userID = USM.shared.getUser().id
            else {
                SMM().showError(title: "Sorry", message: "Please select the disability")
                return
            }
            self.showLoadingIndicator(withDimView: true)
            SchoolManager.shared.insertSocialMultiMedia(data: InsertSocialMultiMedia(SchoolId: schoolID,
                                                                                     FileUrlByteString: selectedImageString)) {[weak self] status in
                
                SchoolManager.shared.fetchAllSchoolsForSchool {[weak self] status in
                    self?.hideLoadingIndicator()
                    if status { DispatchQueue.main.async {[weak self] in self?.showThankYou() } }
                }
            }
        case .schoolSocialMedia:
            guard let accountType = data["account_type"] as? String,
                  let accountTypeID = APPMetaDataHandler.shared.getSocialMediaList(byName: accountType)?.mId,
                  accountTypeID != -1,
                  let link = data["link"] as? String,
                  let userID = USM.shared.getUser().id
            else {
                SMM().showError(title: "Sorry", message: "Please select the disability")
                return
            }
            self.showLoadingIndicator(withDimView: true)
            
            SchoolManager.shared.insertSocialMediaLink(data: InsertSocialMediaLink(AccountTypeID: accountTypeID, RelID: userID, SocialMediaLink: link) ) {[weak self] status in
                
                SchoolManager.shared.fetchAllSchoolsForSchool {[weak self] status in
                    self?.hideLoadingIndicator()
                    if status { DispatchQueue.main.async {[weak self] in self?.showThankYou()} }
                }
            }
        case .schoolWeCanEducate:
            guard let disability = data["we_can_educate"] as? String,
                  let disabilityId = APPMetaDataHandler.shared.getDisabilities(byName: disability)?.disabilityId,
                  disabilityId != -1,
                  let userID = USM.shared.getUser().id
            else {
                SMM().showError(title: "Sorry", message: "Please select the disability")
                return
            }
            
            self.showLoadingIndicator(withDimView: true)
            SchoolManager.shared.insertDisabilityStatus(data: InsertDisabilityStatus(DisabilityStatusId: disabilityId,
                                                                                     UserId: userID)) {[weak self] status in
                
                SchoolManager.shared.fetchAllSchoolsForSchool {[weak self] status in
                    self?.hideLoadingIndicator()
                    if status { DispatchQueue.main.async {[weak self] in self?.showThankYou() } }
                }
            }
        case .personalInformation:
            guard let first_name = data["first_name"] as? String,
                  let last_name = data["last_name"] as? String,
                  let email = data["email"] as? String,
                  let contact_number = data["contact_number"] as? String,
                  let gender = data["Gender"] as? String,
                  let CNIC = data["CNIC"] as? String,
                  let address = data["address"] as? String,
                  let district = data["district"] as? String,
                  let disability = data["disability"] as? String,
                  let userID = USM.shared.getUser().jobSeekerDetailInfo?.userID
            else { return }
            
            let disId = AMDH.shared.getDisabilities(byName: disability)?.disabilityId ?? 0
            let genID = AMDH.shared.getGenders(byName: gender)?.genderId ?? 0
            let cdDob = (data["Dob"] as? String) ?? "01/01/1990"
            let dob = cdDob.toFormattedDate()
            print(dob ?? "")
            
            let data = UpdatePersonalInformationJobCreds(userID: userID,
                                                         Address: address,
                                                         DisabilityId: disId,
                                                         EmailAddress: email,
                                                         Gender: genID,
                                                         oUser: UpdatePersonalInformationJobCreds.oUser(FirstName: first_name,
                                                                                                        LastName: last_name,
                                                                                                        CNIC: CNIC,
                                                                                                        ContactNo: contact_number))
            self.showLoadingIndicator(withDimView: true)
            JobManager.shared.updatePersonalInformationJob(data: data) {[weak self] status in
                self?.hideLoadingIndicator()
                if status {
                    USM.shared.updatedUser {_ in
                        SMM.shared.showStatusSuccess(message: "Profile Updated")
                        DispatchQueue.main.async {[weak self] in
                            self?.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        case .education:
            guard let institution = data["institute_name"] as? String,
                  let className = data["class"] as? String,
                  let date_from = data["date_from"] as? String,
                  let date_to = data["date_to"] as? String,
                  let userID = USM.shared.getUser().jobSeekerDetailInfo?.id
            else { return }
            let duration = "\(date_from) - \(date_to)"
            let data = InsertJobSeekerEducationCreds(Degree: className, Duration: duration, Institution: institution, RelID: userID)
            self.showLoadingIndicator(withDimView: true)
            JobManager.shared.insertJobSeekerEducation(data: data) {[weak self] status in
                self?.hideLoadingIndicator()
                if status {
                    USM.shared.updatedUser {_ in
                        SMM.shared.showStatusSuccess(message: "Education Updated")
                        DispatchQueue.main.async {[weak self] in
                            self?.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        case .workExperience:
            guard let companyName = data["company_name"] as? String,
                  let jobTitle = data["job_title"] as? String,
                  let date_from = data["date_from"] as? String,
                  let date_to = data["date_to"] as? String,
                  let userID = USM.shared.getUser().jobSeekerDetailInfo?.id
            else { return }
            let duration = "\(date_from) - \(date_to)"
            let data = InsertJobSeekerWorkExperienceCreds(CompanyName: companyName, Duration: duration, JobTitle: jobTitle, RelID: userID)
            JobManager.shared.insertJobSeekerWorkExperience(data: data) {[weak self] status in
                self?.hideLoadingIndicator()
                if status {
                    USM.shared.updatedUser {_ in
                        SMM.shared.showStatusSuccess(message: "Work Experience Updated")
                        DispatchQueue.main.async {[weak self] in
                            self?.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        case .technicalSkills:
            guard let skill = data["skill"] as? String,
                  let userID = USM.shared.getUser().jobSeekerDetailInfo?.id
            else { return }
            let data = InsertJobSeekerTechnicalSkillsCreds(RelID: userID, SkillDescription: skill)
            JobManager.shared.insertJobSeekerTechnicalSkills(data: data) {[weak self] status in
                self?.hideLoadingIndicator()
                if status {
                    USM.shared.updatedUser {_ in
                        SMM.shared.showStatusSuccess(message: "Work Experience Updated")
                        DispatchQueue.main.async {[weak self] in
                            self?.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        case .aboutMyself:
            break
        case .jobAdditionalInfo:
            guard let language = data["language"] as? String,
                  let userID = USM.shared.getUser().jobSeekerDetailInfo?.id
            else { return }
            let data = InsertJobSeekerAdditionalInfoCreds(language: language, RelID: userID)
            JobManager.shared.insertJobSeekerAdditionalInfo(data: data) {[weak self] status in
                self?.hideLoadingIndicator()
                if status {
                    USM.shared.updatedUser {_ in
                        SMM.shared.showStatusSuccess(message: "Additional Info Updated")
                        DispatchQueue.main.async {[weak self] in
                            self?.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        case .certification:
            guard let CertificationName = data["certification_name"] as? String,
                  let Issuer = data["institute_name"] as? String,
                  let date_from = data["date_from"] as? String,
                  let date_to = data["date_to"] as? String,
                  let userID = USM.shared.getUser().jobSeekerDetailInfo?.id
            else { return }
            let duration = "\(date_from) - \(date_to)"
            let data = UpdateJobSeekerCertificationsCreds(CertificationName: CertificationName, Duration: duration, Issuer: Issuer, RelID: userID)
            JobManager.shared.updateJobSeekerCertifications(data: data) {[weak self] status in
                self?.hideLoadingIndicator()
                if status {
                    USM.shared.updatedUser {_ in
                        SMM.shared.showStatusSuccess(message: "Certification Updated")
                        DispatchQueue.main.async {[weak self] in
                            self?.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        case .acceptJobApplication:
            break
        case .rejectJobApplication:
            break
        case .personalInformationEmployer:
            break
        case .socialMediaEmployer:
            break
        case .weProvideJobEmployer:
            break
        case .accessibilityMaterialEmployer:
            break
        }
    }
    
    private func showThankYou() {
        DispatchQueue.main.async {
            let storyboard = getStoryBoard(.main)
            let contentVC = storyboard.instantiateViewController(ofType: ThankYouViewController.self)
            contentVC.messageThankYou = .updateSchoolInfo
            contentVC.moveThankYou = .stay
            openModuleOverFullScreen(controller: contentVC)
        }
    }
}

extension FormBuilderViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate {
    private func presentActionSheet() {
        let actionSheet = UIAlertController(title: "Select Option", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Select Image", style: .default) { _ in
            self.openImagePicker()
        })
        
//        actionSheet.addAction(UIAlertAction(title: "Select Document", style: .default) { _ in
//            self.openDocumentPicker()
//        })
        
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
            //                imageView.image = image
//            print(image)
            switch type {
            case .studentProfile:
                if selectImageName == "upload_profile_picture" {
                    studentDetails?.profilePictureString = imageToByteString(image: image)
                    studentDetails?.profilePictureName = "\(UUID().uuidString).jpg"
                    studentDetails?.hasPPUploaded = true
                }
                if selectImageName == "upload_disability_certificate" {
                    studentDetails?.disabilityCertificateString = imageToByteString(image: image)
                    studentDetails?.disabilityCertName = "\(UUID().uuidString).jpg"
                    studentDetails?.hasDisCertUploaded = true
                }
            case .schoolSocialMultiMedia, .acceptJobApplication:
                selectedImageString = self.imageToByteString(image: image) ?? ""
            default: break
            }
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // UIDocumentPickerDelegate method
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let documentURL = urls.first {
            print("Selected document URL: \(documentURL)")
        }
    }
    
    func imageToByteString(image: UIImage,_ isFromURL: Bool = false) -> String? {
        // Convert UIImage to Data (JPEG with 80% quality or PNG)
        guard let imageData = image.jpegData(compressionQuality: isFromURL ? 1.0 : 0.5) else { return nil }
        // Convert Data to Base64 encoded string
        return imageData.base64EncodedString()
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
