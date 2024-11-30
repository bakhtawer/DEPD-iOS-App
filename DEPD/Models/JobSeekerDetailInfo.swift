//
//  JobSeekerDetailInfo.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 24/11/2024.
//


// Job Seeker Detail Info
struct JobSeekerDetailInfo: Codable {
    var id: Int?
    var userID: Int?
    var name: String?
    var address: String?
    var disabilityId: Int?
    var disabilityName: String?
    var age: Int?
    var disabilityCertificateURL: String?
    var profilePicture: String?
    var profilePictureBytesString: String?
    var profilePictureName: String?
    var gender: Int?
    var searchTags: String?
    var dateOfBirth: String?
    var district: String?
    var emailAddress: String?
    var cvFileUploadName: String?
    var cvFileUploadByteString: String?
    var disabilityCertificateName: String?
    var disabilityCertificateByteString: String?
    
    var aboutInfo: AboutInfo?
    var jobSeekerEducationInfo: [JobSeekerEducation]?
    var jobSeekerWorkExperience: [JobSeekerWorkExperience]?
    var jobSeekerTechnicalSkill: [JobSeekerTechnicalSkill]?
    var jobSeekerAdditionalInfo: [JobSeekerAdditionalInfo]?
    var jobSeekerCertification: [JobSeekerCertification]?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case userID = "UserID"
        case name = "Name"
        case address = "Address"
        case disabilityId = "DisabilityId"
        case disabilityName = "DisabilityName"
        case age = "Age"
        case disabilityCertificateURL = "DisabilityCertificateURL"
        case profilePicture = "ProfilePicture"
        case profilePictureBytesString = "ProfilePictureBytesString"
        case profilePictureName = "ProfilePictureName"
        case gender = "Gender"
        case searchTags = "SearchTags"
        case dateOfBirth = "DateOfBirth"
        case district = "District"
        case emailAddress = "EmailAddress"
        case cvFileUploadName = "CVFileUploadName"
        case cvFileUploadByteString = "CVFileUploadByteString"
        case disabilityCertificateName = "DisabilityCertificateName"
        case disabilityCertificateByteString = "DisabilityCertificateByteString"
        
        case aboutInfo = "aboutinfo"
        case jobSeekerEducationInfo = "jobSeekerEducationInfo"
        case jobSeekerWorkExperience = "JobSeekerWorkExperience"
        case jobSeekerTechnicalSkill = "JobSeekerTechnicalSkill"
        case jobSeekerAdditionalInfo = "JobSeekerAdditionalInfo"
        case jobSeekerCertification = "JobSeekerCertification"
    }
}

// About Info
struct AboutInfo: Codable {
    var id: Int?
    var relId: Int?
    var aboutText: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case relId = "RelId"
        case aboutText = "AboutText"
    }
}

// Job Seeker Education
struct JobSeekerEducation: Codable {
    var id: Int?
    var relId: Int?
    var institution: String?
    var degree: String?
    var duration: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case relId = "RelId"
        case institution = "Institution"
        case degree = "Degree"
        case duration = "Duration"
    }
}

// Job Seeker Work Experience
struct JobSeekerWorkExperience: Codable {
    var id: Int?
    var relId: Int?
    var companyName: String?
    var jobTitle: String?
    var duration: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case relId = "RelId"
        case companyName = "CompanyName"
        case jobTitle = "JobTitle"
        case duration = "Duration"
    }
}


// Job Seeker Work Experience
struct JobSeekerTechnicalSkill: Codable {
    var id: Int?
    var relId: Int?
    var skillDescription: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case relId = "RelId"
        case skillDescription = "SkillDescription"
    }
}

// Job Seeker AdditionalInfo
struct JobSeekerAdditionalInfo: Codable {
    var id: Int?
    var name: String?
    var userId: Int?
    var isActive: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case userId = "UserId"
        case isActive = "IsActive"
    }
}

// Job Seeker Work Experience
struct JobSeekerCertification: Codable {
    var id: Int?
    var relId: Int?
    var issuer: String?
    var certificationName: String?
    var duration: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case relId = "RelId"
        case issuer = "Issuer"
        case certificationName = "CertificationName"
        case duration = "Duration"
    }
}
