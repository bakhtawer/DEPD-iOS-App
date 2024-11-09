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
    var cdAddress:String?
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
    var cdAddress:String?
    var cdPresentAddress:String?
    
//    Complain Details
    var complainDetailsCompanyName:String?
    var complainDetailsCompanyEmailAddress:String?
    var complainDetailsCompanyString:String?
    var complainDetailsReasonOfDenialOfJob:String?
    var complainDetailsCompanyContactNumber:String?
    var complainDetailsCompanyAddress:String?
    var complainDetailsPresentAddress:String?
}
