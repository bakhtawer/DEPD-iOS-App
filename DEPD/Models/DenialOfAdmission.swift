//
//  DenialOfAdmission.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 09/11/2024.
//

/*
Denial of Admission
Parent/Guardian Details
If the complainant is over 18 years of age than do not fill this part
Name
CNIC
Email
Relation with Candidate
Contact No
Candidate Details
Name
Gender
CNIC
District
Father Name
Date Of Birth dd/mm/yyyy
Contact No
Disability
Address
Present Address here (Please mention Area / Taluka)
Complain Details
Institute Name
Institute Email Address
District
Reason of Denial of Admission
Institute Contact Number
Institute Address
Present Address here (Please mention Area / Taluka)

Record Your Message
Upload Related Documents if you have any
I herby that all information provided in this complaint form is true and accurate to the best of my knowledge. I understand that providing false information may result in legal action against me.
*/

class DenialOfAdmission {
//    Candidate Details
    var cdName:String?
    var cdGender:String?
    var cdCNIC:String?
    var cdDistrict:String?
    var cdFatherName:String?
    var cdDob:String?
    var cdContactNo:String?
    var cdDisability:String?
    var cdPresentAddress:String?
    
//    Parent/Guardian Details
    var pdName:String?
    var pdCNIC:String?
    var pdEmail:String?
    var pdRelationWithCandidate:String?
    var pdContactNo:String?
    
    
//    Complain Details
    var complainDetailsInstituteName:String?
    var complainDetailsInstituteEmailAddress:String?
    var complainDetailsDistrict:String?
    var complainDetailsReasonOfDenialOfAdmission:String?
    var complainDetailsInstituteContactNumber:String?
    var complainDetailsInstituteAddress:String?
    var complainDetailsPresentAddress:String?
    
    var complainDetailsCheckBox:Bool?
    
    func makeTestValues() {
        cdName = "cdName"
        cdGender = "cdGender"
        cdCNIC = "cdCNIC"
        cdDistrict = "cdDistrict"
        cdFatherName = "cdFatherName"
        cdDob = "22/06/1992"
        cdContactNo = "cdContactNo"
        cdDisability = "cdDisability"
        cdPresentAddress = "cdPresentAddress"
        pdName = "pdName"
        pdCNIC = "pdCNIC"
        pdEmail = "pdEmail"
        pdRelationWithCandidate = "pdRelationWithCandidate"
        pdContactNo = "pdContactNo"
        complainDetailsInstituteName = "complainDetailsInstituteName"
        complainDetailsInstituteEmailAddress = "complainDetailsInstituteEmailAddress"
        complainDetailsDistrict = "complainDetailsDistrict"
        complainDetailsReasonOfDenialOfAdmission = "complainDetailsReasonOfDenialOfAdmission"
        complainDetailsInstituteContactNumber = "complainDetailsInstituteContactNumber"
        complainDetailsInstituteAddress = "complainDetailsInstituteAddress"
        complainDetailsPresentAddress = "complainDetailsPresentAddress"
        complainDetailsCheckBox = true
    }
}

class DenialOfJob {
//    Candidate Details
    var cdName:String?
    var cdGender:String?
    var cdCNIC:String?
    var cdDistrict:String?
    var cdFatherName:String?
    var cdDob:String?
    var cdContactNo:String?
    var cdDisability:String?
    var cdPresentAddress:String?
    
//    Complain Details
    var complainDetailsCompanyName:String?
    var complainDetailsCompanyEmailAddress:String?
    var complainDetailsCompanyString:String?
    var complainDetailsReasonOfDenialOfJob:String?
    var complainDetailsCompanyContactNumber:String?
    var complainDetailsPresentAddress:String?
    var complainDetailsDistrict:String?
    var complainDetailsCheckBox:Bool?
    
    func makeTestValues() {
        cdName = "cdName"
        cdGender = "cdGender"
        cdCNIC = "cdCNIC"
        cdDistrict = "cdDistrict"
        cdFatherName = "cdFatherName"
        cdDob = "22/06/1992"
        cdContactNo = "cdContactNo"
        cdDisability = "cdDisability"
        cdPresentAddress = "cdPresentAddress"
        complainDetailsCompanyName = "complainDetailsCompanyName"
        complainDetailsCompanyEmailAddress = "complainDetailsCompanyEmailAddress"
        complainDetailsCompanyString = "complainDetailsCompanyString"
        complainDetailsReasonOfDenialOfJob = "complainDetailsReasonOfDenialOfJob"
        complainDetailsCompanyContactNumber = "complainDetailsCompanyContactNumber"
        complainDetailsPresentAddress = "complainDetailsPresentAddress"
        complainDetailsDistrict = "complainDetailsDistrict"
        complainDetailsCheckBox = true
    }
}

class DenialOfAdmissionCreds: Codable {
    var AudioFileName: String?
    var cdINstituteAddress: String?
    var cdINstituteContactNumber: String?
    var cdINstituteDistrictId: Int?
    var cdINstituteEmailAddress: String?
    var cdINstituteName: String?
    var cdIReason: String?
    var cdtAddress: String?
    var cdtCNIC: String?
    var cdtContactNo: String?
    var cdtDateOfBirth: String?
    var cdtDisablityId: Int?
    var cdtDistrictId: Int?
    var cdtFatherName: String?
    var cdtGender: Int?
    var cdtName: String?
    var DocFileName: String?
    var prCNIC: String?
    var prContactNo: String?
    var prEmail: String?
    var prName: String?
    var prRelationwithCandidate: Int?
    var DocFileByteString: String?
    var cdReason: String?
    var cdCompanyAddress: String?
    var cdCompanyContactNumber: String?
    var cdCompanyDistrictId: Int?
    var cdCompanyEmailAddress: String?
    var cdCompanyName: String?
    
    init(AudioFileName: String?,
         cdINstituteAddress: String?,
         cdINstituteContactNumber: String?,
         cdINstituteDistrictId: Int?,
         cdINstituteEmailAddress: String?,
         cdINstituteName: String?,
         cdIReason: String?,
         cdtAddress: String?,
         cdtCNIC: String?,
         cdtContactNo: String?,
         cdtDateOfBirth: String?,
         cdtDisablityId: Int?,
         cdtDistrictId: Int?,
         cdtFatherName: String?,
         cdtGender: Int?,
         cdtName: String?,
         DocFileName: String?,
         prCNIC: String?,
         prContactNo: String?,
         prEmail: String?,
         prName: String?,
         prRelationwithCandidate: Int?,
         DocFileByteString: String?,
         cdReason: String?,
         cdCompanyAddress: String?,
         cdCompanyContactNumber: String?,
         cdCompanyDistrictId: Int?,
         cdCompanyEmailAddress: String?,
         cdCompanyName: String?
    ) {
        self.AudioFileName = AudioFileName
        self.cdINstituteAddress = cdINstituteAddress
        self.cdINstituteContactNumber = cdINstituteContactNumber
        self.cdINstituteDistrictId = cdINstituteDistrictId
        self.cdINstituteEmailAddress = cdINstituteEmailAddress
        self.cdINstituteName = cdINstituteName
        self.cdIReason = cdIReason
        self.cdtAddress = cdtAddress
        self.cdtCNIC = cdtCNIC
        self.cdtContactNo = cdtContactNo
        self.cdtDateOfBirth = cdtDateOfBirth
        self.cdtDisablityId = cdtDisablityId
        self.cdtDistrictId = cdtDistrictId
        self.cdtFatherName = cdtFatherName
        self.cdtGender = cdtGender
        self.cdtName = cdtName
        self.DocFileName = DocFileName
        self.prCNIC = prCNIC
        self.prContactNo = prContactNo
        self.prEmail = prEmail
        self.prName = prName
        self.prRelationwithCandidate = prRelationwithCandidate
        self.DocFileByteString = DocFileByteString
        self.cdCompanyAddress = cdCompanyAddress
        self.cdCompanyContactNumber = cdCompanyContactNumber
        self.cdCompanyDistrictId = cdCompanyDistrictId
        self.cdCompanyEmailAddress = cdCompanyEmailAddress
        self.cdCompanyName = cdCompanyName
        self.cdReason = cdReason
    }
}
