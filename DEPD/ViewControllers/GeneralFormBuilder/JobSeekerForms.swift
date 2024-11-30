//
//  JobSeeker.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 24/11/2024.
//

extension FormBuilderViewController {
    func populateJobSeekerPersonalInfo() -> [FormField] {
        [
            firstName,
            lastName,
            
            FormField(fieldType: .email,
                      placeholder: "email".localized(),
                      name: "email",
                      value: USM.shared.getUser().jobSeekerDetailInfo?.emailAddress,
                      isRequired: true),
            
            FormField(fieldType: .number,
                      placeholder: "contact_number".localized(),
                      name: "contact_number",
                      value: USM.shared.getUser().contactNo,
                      isRequired: true),
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getGendersName()),
                      placeholder: "gender".localized(),
                      name: "Gender",
                      value: "\(String(describing: AMDH.shared.getGenders(byID: UserSessionManager.shared.getUser().jobSeekerDetailInfo?.gender ?? -1)))",
                      isRequired: false),
            
            FormField(fieldType: .date,
                      placeholder: "dob".localized(),
                      name: "Dob", value: USM.shared.getUser().jobSeekerDetailInfo?.dateOfBirth?.convertMicrosoftDateString, isRequired: false),
            
            FormField(fieldType: .text,
                      placeholder: "cnic".localized(),
                      name: "CNIC",
                      value: UserSessionManager.shared.getUser().cnic,
                      isRequired: true, isEnabled: false),
            
            
            FormField(fieldType: .text,
                      placeholder: "address".localized(),
                      name: "address",
                      value: USM.shared.getUser().jobSeekerDetailInfo?.address,
                      isRequired: true),
            
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDistrictsNames()),
                      placeholder: "district".localized(),
                      name: "district",
                      value: USM.shared.getUser().jobSeekerDetailInfo?.district,
                      isRequired: false),
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDisabilitiesNames()),
                      placeholder: "disability".localized(),
                      name: "disability",
                      value: "\(String(describing: AMDH.shared.getDisabilities(byID: USM.shared.getUser().jobSeekerDetailInfo?.disabilityId ?? -1)?.name?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""))",
                      isRequired: false),

            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
        ]
    }
    
    func populateJobSeekerEducation() -> [FormField] {
        [
            FormField(fieldType: .text, placeholder: "institute_name".localized(), name: "institute_name", value: nil, isRequired: true),
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getClassesName()),
                      placeholder: "class".localized(),
                      name: "class",
                      value: nil,
                      isRequired: true),
            
            FormField(fieldType: .dateFrom,
                      placeholder: "date_from".localized(),
                      name: "date_from",
                      value:nil,
                      isRequired: true),
            
            FormField(fieldType: .dateTo,
                      placeholder: "date_to".localized(),
                      name: "date_to",
                      value:nil,
                      isRequired: true),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
        ]
    }
    
    func populateJobSeekerWorkExperience() -> [FormField] {
        [
            FormField(fieldType: .text, placeholder: "company_name".localized(), name: "company_name", value: nil, isRequired: true),
            
            FormField(fieldType: .text, placeholder: "job_title".localized(), name: "job_title", value: nil, isRequired: true),
            
            FormField(fieldType: .dateFrom,
                      placeholder: "date_from".localized(),
                      name: "date_from",
                      value:nil,
                      isRequired: true),
            
            FormField(fieldType: .dateTo,
                      placeholder: "date_to".localized(),
                      name: "date_to",
                      value:nil,
                      isRequired: true),
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
        ]
    }
    
    func populateJobSeekerAboutMySelf() -> [FormField] {
        [
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .textLong, placeholder: "about_my_self".localized(), name: "about_my_self", value: USM.shared.getUser().jobSeekerDetailInfo?.aboutInfo?.aboutText, isRequired: true),
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
        ]
    }
    
    func populateJobSeekerTechnicalSkills() -> [FormField] {
        [
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getTechnicalSkillListName()),
                      placeholder: "skill".localized(),
                      name: "skill",
                      value: nil,
                      isRequired: true),
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
        ]
    }
    
    func populateJobSeekerAdditionalInfo() -> [FormField] {
        [
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getLanguagesName()),
                      placeholder: "languages".localized(),
                      name: "language",
                      value: nil,
                      isRequired: true),
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
        ]
    }
    
    func populateJobSeekerCertification() -> [FormField] {
        [
            FormField(fieldType: .text, placeholder: "institute_name".localized(), name: "institute_name", value: nil, isRequired: true),
            
            FormField(fieldType: .text, placeholder: "certification_name".localized(), name: "certification_name", value: nil, isRequired: true),
            
            FormField(fieldType: .dateFrom,
                      placeholder: "date_from".localized(),
                      name: "date_from",
                      value:nil,
                      isRequired: true),
            
            FormField(fieldType: .dateTo,
                      placeholder: "date_to".localized(),
                      name: "date_to",
                      value:nil,
                      isRequired: true),
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
        ]
    }
}
