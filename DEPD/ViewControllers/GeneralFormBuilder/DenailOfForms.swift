//
//  DenailOfForms.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 09/11/2024.
//

extension FormBuilderViewController {
    func populateCandidateDetails() -> [FormField] {
        [
            FormField(fieldType: .text, placeholder: "full_name".localized(),
                      name: "cdName",
                      value: denialOfAdmission?.cdName, isRequired: false),
            
            FormField(fieldType: .text, placeholder: "father_name".localized(),
                      name: "cdFatherName",
                      value: denialOfAdmission?.cdFatherName,
                      isRequired: false),
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getGendersName()),
                      placeholder: "gender".localized(),
                      name: "cdGender",
                      value: denialOfAdmission?.cdGender,
                      isRequired: false),
            FormField(fieldType: .date,
                      placeholder: "dob".localized(),
                      name: "cdDob", value: denialOfAdmission?.cdDob, isRequired: true),
            FormField(fieldType: .number, placeholder: "cnic".localized(), name: "cdCNIC", value: denialOfAdmission?.cdCNIC, isRequired: false),
            FormField(fieldType: .number, placeholder: "contact_no".localized(), name: "cdContactNo", value: denialOfAdmission?.cdContactNo, isRequired: false),
            FormField(fieldType: .text, placeholder: "present_address".localized(), name: "cdPresentAddress", value: denialOfAdmission?.cdPresentAddress, isRequired: false),
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDistrictsNames()),
                      placeholder: "district".localized(),
                      name: "cdDistrict",
                      value: denialOfAdmission?.cdDistrict,
                      isRequired: false),
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDisabilitiesNames()),
                      placeholder: "disability".localized(),
                      name: "cdDisability",
                      value: denialOfAdmission?.cdDisability,
                      isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false)
        ]
    }
    
    func populateParentsDetails() -> [FormField] {
        [
            FormField(fieldType: .text, placeholder: "full_name".localized(), name: "pdName",
                      value: denialOfAdmission?.pdName, isRequired: false),
            
            FormField(fieldType: .number, placeholder: "cnic".localized(), name: "pdCNIC", value: denialOfAdmission?.pdCNIC, isRequired: false),
            
            FormField(fieldType: .number, placeholder: "contact_no".localized(), name: "pdContactNo", value: denialOfAdmission?.pdContactNo, isRequired: false),
            
            FormField(fieldType: .email, placeholder: "email".localized(), name: "pdEmail", value: denialOfAdmission?.pdEmail, isRequired: false),
            
            FormField(fieldType: .dropdown(options: ["Father", "Mother", "Guardian"]),
                      placeholder: "relation_with_cadidate".localized(),
                      name: "pdRelationWithCandidate",
                      value: denialOfAdmission?.pdRelationWithCandidate,
                      isRequired: false),
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false)
        ]
    }
    
    func populateComplainDetailsAdmission() -> [FormField] {
        [
            
//            Institute Name
//            Institute Email Address
//            District
//            select
//            Reason of Denial of Addmission
            
            FormField(fieldType: .text, placeholder: "institute_name".localized(), name: "complainDetailsInstituteName",
                      value: denialOfAdmission?.complainDetailsInstituteName, isRequired: false),
            
            FormField(fieldType: .text, placeholder: "institute_email".localized(), name: "complainDetailsInstituteEmailAddress",
                      value: denialOfAdmission?.complainDetailsInstituteEmailAddress, isRequired: false),
            
            FormField(fieldType: .email, placeholder: "institute_contact_no".localized(), name: "complainDetailsInstituteContactNumber",
                      value: denialOfAdmission?.complainDetailsInstituteContactNumber, isRequired: false),
            
            FormField(fieldType: .text, placeholder: "present_address".localized(), name: "complainDetailsPresentAddress",
                      value: denialOfAdmission?.complainDetailsPresentAddress, isRequired: false),
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDistrictsNames()),
                      placeholder: "district".localized(),
                      name: "complainDetailsDistrict",
                      value: denialOfAdmission?.complainDetailsDistrict,
                      isRequired: false),
            
            FormField(fieldType: .textLong, placeholder: "reason_of_denial_of_admission".localized(), name: "complainDetailsReasonOfDenialOfAdmission",
                      value: denialOfAdmission?.complainDetailsReasonOfDenialOfAdmission, isRequired: false),
            
            FormField(fieldType: .recordYourMessage, placeholder: "record_your_message".localized(), name: "record_your_message",
                      value: nil, isRequired: false),
            
            FormField(fieldType: .uploadFile, placeholder: "upload_related_documents".localized(), name: "upload_related_documents_addmission",
                      value: nil, isRequired: false),
            
            FormField(fieldType: .checkbox, placeholder: "i_herby_that".localized(), name: "complainDetailsCheckBox",
                      value: denialOfAdmission?.complainDetailsCheckBox?.makeItString, isRequired: false),
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
        ]
    }
    
    func populateCandidateDetailsJob() -> [FormField] {
        [
            FormField(fieldType: .text, placeholder: "full_name".localized(),
                      name: "cdName",
                      value: denialOfJob?.cdName, isRequired: false),
            
            FormField(fieldType: .text, placeholder: "father_name".localized(),
                      name: "cdFatherName",
                      value: denialOfJob?.cdFatherName,
                      isRequired: false),
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getGendersName()),
                      placeholder: "gender".localized(),
                      name: "cdGender",
                      value: denialOfJob?.cdGender,
                      isRequired: false),
            FormField(fieldType: .date,
                      placeholder: "dob".localized(),
                      name: "cdDob", value: denialOfJob?.cdDob, isRequired: false),
            FormField(fieldType: .number, placeholder: "cnic".localized(), name: "cdCNIC", value: denialOfJob?.cdCNIC, isRequired: false),
            FormField(fieldType: .number, placeholder: "contact_no".localized(), name: "cdContactNo", value: denialOfJob?.cdContactNo, isRequired: false),
            FormField(fieldType: .text, placeholder: "present_address".localized(), name: "cdPresentAddress", value: denialOfJob?.cdPresentAddress, isRequired: false),
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDistrictsNames()),
                      placeholder: "district".localized(),
                      name: "cdDistrict",
                      value: denialOfJob?.cdDistrict,
                      isRequired: false),
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDisabilitiesNames()),
                      placeholder: "disability".localized(),
                      name: "cdDisability",
                      value: denialOfJob?.cdDisability,
                      isRequired: false),
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false)
        ]
    }
    
    func populateComplainDetails() -> [FormField] {
        [
            
            FormField(fieldType: .text, placeholder: "company_name".localized(), name: "complainDetailsCompanyName",
                      value: denialOfJob?.complainDetailsCompanyName, isRequired: false),
            
            FormField(fieldType: .text, placeholder: "company_contact_number".localized(), name: "complainDetailsCompanyContactNumber",
                      value: denialOfJob?.complainDetailsCompanyContactNumber, isRequired: false),
            
            FormField(fieldType: .email, placeholder: "company_email_address".localized(), name: "complainDetailsCompanyEmailAddress",
                      value: denialOfJob?.complainDetailsCompanyEmailAddress, isRequired: false),
            
            FormField(fieldType: .text, placeholder: "present_address".localized(), name: "complainDetailsPresentAddress",
                      value: denialOfJob?.complainDetailsPresentAddress, isRequired: false),
            
            
            FormField(fieldType: .dropdown(options: APPMetaDataHandler.shared.getDistrictsNames()),
                      placeholder: "district".localized(),
                      name: "complainDetailsDistrict",
                      value: denialOfJob?.complainDetailsDistrict,
                      isRequired: false),
            
            
            FormField(fieldType: .textLong, placeholder: "reason_of_denial_of_job".localized(), name: "complainDetailsReasonOfDenialOfJob", value: denialOfJob?.complainDetailsReasonOfDenialOfJob, isRequired: false),
            
            FormField(fieldType: .recordYourMessage, placeholder: "record_your_message".localized(), name: "record_your_message", value: nil, isRequired: false),
            
            FormField(fieldType: .uploadFile, placeholder: "upload_document".localized(), name: "upload_related_documents_job", value: nil, isRequired: false),
            
            FormField(fieldType: .checkbox, placeholder: "i_herby_that".localized(), name: "complainDetailsCheckBox", value: denialOfJob?.complainDetailsCheckBox?.makeItString, isRequired: false),
            
            FormField(fieldType: .gap, placeholder: "", name: "", value: nil, isRequired: false),
        ]
    }
}
