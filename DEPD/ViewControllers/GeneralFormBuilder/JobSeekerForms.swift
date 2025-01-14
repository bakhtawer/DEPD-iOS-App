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
                      value: "\(String(describing: AMDH.shared.getGenders(byID: UserSessionManager.shared.getUser().jobSeekerDetailInfo?.gender ?? -1)?.name ?? ""))",
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
                      placeholder: "class_level".localized(),
                      name: "class",
                      value: nil,
                      isRequired: true),
            
            FormField(fieldType: .dateFrom,
                      placeholder: "from".localized(),
                      name: "date_from",
                      value:nil,
                      isRequired: true),
            
            FormField(fieldType: .dateTo,
                      placeholder: "to".localized(),
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
                      placeholder: "from".localized(),
                      name: "date_from",
                      value:nil,
                      isRequired: true),
            
            FormField(fieldType: .dateTo,
                      placeholder: "to".localized(),
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
            FormField(fieldType: .gapTop, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .textLong, placeholder: "about_myself".localized(), name: "about_my_self", value: USM.shared.getUser().jobSeekerDetailInfo?.aboutInfo?.aboutText, isRequired: true),
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
        ]
    }
    
    func populateJobSeekerTechnicalSkills() -> [FormField] {
        [
            FormField(fieldType: .gapTop, placeholder: "", name: "", value: nil, isRequired: false),
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
            FormField(fieldType: .gapTop, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getLanguagesName()),
                      placeholder: "language".localized(),
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
                      placeholder: "from".localized(),
                      name: "from",
                      value:nil,
                      isRequired: true),
            
            FormField(fieldType: .dateTo,
                      placeholder: "to".localized(),
                      name: "date_to",
                      value:nil,
                      isRequired: true),
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
        ]
    }
    
    func populateJobAcceptApplication() -> [FormField] {
        [
            FormField(fieldType: .dateJoning, placeholder: "date_of_joining".localized(), name: "date_of_joining", value: nil, isRequired: true),
            FormField(fieldType: .uploadFile, placeholder: "upload_document".localized(), name: "upload_document", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
        ]
    }
    func populateJobRejectApplication() -> [FormField] {
        [
            FormField(fieldType: .textLong, placeholder: "reason".localized(), name: "reason", value: nil, isRequired: true),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
        ]
    }
}

extension FormBuilderViewController {
    
    func populatePersonalInformationEmployer() -> [FormField] {
        [
            FormField(fieldType: .text,
                      placeholder: "company_name".localized(),
                      name: "company_name",
                      value: USM.shared.getUser().companyDetailInfo?.companyName,
                      isRequired: true),
            
            FormField(fieldType: .text,
                      placeholder: "full_name".localized(),
                      name: "fullname",
                      value: USM.shared.getUserFullName(),
                      isRequired: true),
            
            FormField(fieldType: .email,
                      placeholder: "email".localized(),
                      name: "email",
                      value: USM.shared.getUser().companyDetailInfo?.emailAdress,
                      isRequired: true),
            
            FormField(fieldType: .number,
                      placeholder: "contact_number".localized(),
                      name: "contact_number",
                      value: USM.shared.getUser().contactNo,
                      isRequired: true),
            
            FormField(fieldType: .dropdown(options: AMDH.shared.getDesignations()),
                      placeholder: "designation".localized(),
                      name: "designation",
                      value: USM.shared.getUser().companyDetailInfo?.designation,
                      isRequired: true),
            
            FormField(fieldType: .number,
                      placeholder: "cnic".localized(),
                      name: "cnic",
                      value: USM.shared.getUser().cnic,
                      isRequired: true, isEnabled: false),
            
            FormField(fieldType: .text,
                      placeholder: "address".localized(),
                      name: "address",
                      value: USM.shared.getUser().companyDetailInfo?.location,
                      isRequired: true),
            
            FormField(fieldType: .number,
                      placeholder: "ntn_number".localized(),
                      name: "ntn_number",
                      value: USM.shared.getUser().companyDetailInfo?.nTNNumber,
                      isRequired: true),
            
            FormField(fieldType: .text,
                      placeholder: "registration_number".localized(),
                      name: "registration_number",
                      value: USM.shared.getUser().companyDetailInfo?.registirationNumber,
                      isRequired: true),
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDistrictsNames()),
                      placeholder: "district".localized(),
                      name: "district",
                      value: USM.shared.getUser().companyDetailInfo?.district,
                      isRequired: false),
            
            FormField(fieldType: .number,
                      placeholder: "availbale_seats_for_pwds".localized(),
                      name: "availbale_seats_for_pwds",
                      value: USM.shared.getUser().companyDetailInfo?.availableQuotaForPWDs,
                      isRequired: true),
            
            FormField(fieldType: .text,
                      placeholder: "website".localized(),
                      name: "website",
                      value: USM.shared.getUser().companyDetailInfo?.website,
                      isRequired: true),
            
            FormField(fieldType: .textLong,
                      placeholder: "about_your_company".localized(),
                      name: "about_your_company",
                      value: USM.shared.getUser().companyDetailInfo?.aboutDescription,
                      isRequired: true)
            
        ]
    }
    func populateSocialMediaEmployer() -> [FormField] {
        [
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
    }
    func populateWeProvideJobEmployer() -> [FormField] {
        [
            FormField(fieldType: .gapTop, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDisabilitiesNames()),
                      placeholder: "disability".localized(),
                      name: "disability",
                      value: nil,
                      isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
        ]
    }
    func populateAccessibilityMaterialEmplor() -> [FormField] {
        [
            FormField(fieldType: .gapTop, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getAccessibilityListName()),
                      placeholder: "accessibility_material".localized(),
                      name: "accessibility_material",
                      value: nil,
                      isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
        ]
    }
}
