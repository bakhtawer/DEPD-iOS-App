//
//  User.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 06/07/2024.
//

import Foundation

struct User: Codable {
    var id: Int?
    var userTypeId: Int?
    var subTypeId: Int?
    var firstName: String?
    var lastName: String?
    var cnic: String?
    var contactNo: String?
    var password: String?
    var isVerified: Bool?
    var language: String?
    var emailAddress: String?
    var oStudentDetails: StudentDetails?
    var oStudentApplicationDetail: [StudentApplication]?
    var schoolSocialMediaInfo: SchoolSocialMediaInfo?
    var schoolDetailInfo: SchoolDetailInfo?
    
    init() {}
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case userTypeId = "UserTypeId"
        case subTypeId = "SubTypeId"
        case firstName = "FirstName"
        case lastName = "LastName"
        case cnic = "CNIC"
        case contactNo = "ContactNo"
        case password = "Password"
        case isVerified = "IsVerified"
        case language = "Language"
        case emailAddress = "EmailAddress"
        case oStudentDetails
        case oStudentApplicationDetail
        case schoolSocialMediaInfo = "oSchoolSocialMediaInfo"
        case schoolDetailInfo = "oSchoolDetailInfo"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        userTypeId = try container.decodeIfPresent(Int.self, forKey: .userTypeId) ?? -1
        subTypeId = try container.decodeIfPresent(Int.self, forKey: .subTypeId) ?? -1
        firstName = try container.decodeIfPresent(String.self, forKey: .firstName) ?? ""
        lastName = try container.decodeIfPresent(String.self, forKey: .lastName) ?? ""
        cnic = try container.decodeIfPresent(String.self, forKey: .cnic) ?? ""
        contactNo = try container.decodeIfPresent(String.self, forKey: .contactNo) ?? ""
        password = try container.decodeIfPresent(String.self, forKey: .password) ?? ""
        isVerified = try container.decodeIfPresent(Bool.self, forKey: .isVerified) ?? false
        language = try container.decodeIfPresent(String.self, forKey: .language)
        emailAddress = try container.decodeIfPresent(String.self, forKey: .emailAddress)
        oStudentDetails = try container.decodeIfPresent(StudentDetails.self, forKey: .oStudentDetails)
        oStudentApplicationDetail = try container.decodeIfPresent([StudentApplication].self, forKey: .oStudentApplicationDetail)
        schoolSocialMediaInfo = try container.decodeIfPresent(SchoolSocialMediaInfo.self, forKey: .schoolSocialMediaInfo)
        schoolDetailInfo = try container.decodeIfPresent(SchoolDetailInfo.self, forKey: .schoolDetailInfo)
    }
}

struct StudentDetails: Codable {
    var id: Int?
    var fatherName: String?
    var fatherCnic: String?
    var dob: String?
    var formattedDOB: String?
    var genderId: Int?
    var gender: String?
    var formBURL: String?
    var address: String?
    var district: String?
    var disabilityStatusId: Int?
    var previousEducation: String?
    var profilePictureURL: String?
    var disabilityCertificateURL: String?
    var hasPPUploaded: Bool?
    var hasDisCertUploaded: Bool?
    var profilePercentage: Int?
    var profileCompletionPercentage: Int?
    var emailAddress: String?
    
    var profilePictureName: String?
    var profilePictureString: String?
    var disabilityCertificateString: String?
    var disabilityCertName: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case fatherName = "FatherName"
        case fatherCnic = "FatherCNIC"
        case dob = "DOB"
        case formattedDOB = "FormattedDOB"
        case genderId = "GenderId"
        case gender = "Gender"
        case formBURL = "FormBURL"
        case address = "Address"
        case district = "District"
        case disabilityStatusId = "DisabilityStatusId"
        case previousEducation = "PreviousEducation"
        case profilePictureURL = "ProfilePictureURL"
        case disabilityCertificateURL = "DisabilityCertificateURL"
        case hasPPUploaded = "HasPPUploaded"
        case hasDisCertUploaded = "HasDisCertUploaded"
        case profilePercentage = "ProfilePercentage"
        case profileCompletionPercentage = "ProfileCompletionPercentage"
        case emailAddress = "EmailAddress"
        case profilePictureString = "ProfilePictureBytesString"
        case disabilityCertificateString = "DisabilityCertBytesString"
        case profilePictureName = "ProfilePictureName"
        case disabilityCertName = "DisabilityCertName"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        fatherName = try container.decodeIfPresent(String.self, forKey: .fatherName) ?? ""
        fatherCnic = try container.decodeIfPresent(String.self, forKey: .fatherCnic) ?? ""
        dob = try container.decodeIfPresent(String.self, forKey: .dob)
        formattedDOB = try container.decodeIfPresent(String.self, forKey: .formattedDOB)
        genderId = try container.decodeIfPresent(Int.self, forKey: .genderId) ?? -1
        gender = try container.decodeIfPresent(String.self, forKey: .gender) ?? ""
        formBURL = try container.decodeIfPresent(String.self, forKey: .formBURL)
        address = try container.decodeIfPresent(String.self, forKey: .address) ?? ""
        district = try container.decodeIfPresent(String.self, forKey: .district) ?? ""
        disabilityStatusId = try container.decodeIfPresent(Int.self, forKey: .disabilityStatusId) ?? -1
        previousEducation = try container.decodeIfPresent(String.self, forKey: .previousEducation)
        profilePictureURL = try container.decodeIfPresent(String.self, forKey: .profilePictureURL)
        disabilityCertificateURL = try container.decodeIfPresent(String.self, forKey: .disabilityCertificateURL)
        hasPPUploaded = try container.decodeIfPresent(Bool.self, forKey: .hasPPUploaded) ?? false
        hasDisCertUploaded = try container.decodeIfPresent(Bool.self, forKey: .hasDisCertUploaded) ?? false
        profilePercentage = try container.decodeIfPresent(Int.self, forKey: .profilePercentage) ?? 0
        profileCompletionPercentage = try container.decodeIfPresent(Int.self, forKey: .profileCompletionPercentage) ?? 0
        emailAddress = try container.decodeIfPresent(String.self, forKey: .emailAddress)
        profilePictureString = try container.decodeIfPresent(String.self, forKey: .profilePictureString)
        disabilityCertificateString = try container.decodeIfPresent(String.self, forKey: .disabilityCertificateString)
        profilePictureName = try container.decodeIfPresent(String.self, forKey: .profilePictureName)
        disabilityCertName = try container.decodeIfPresent(String.self, forKey: .disabilityCertName)
    }
}

struct StudentApplication: Codable {
    var id: Int?
    var schoolName: String?
    var appliedOnDate: String?
    var className: String?
    var admissionStatus: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case schoolName = "SchoolName"
        case appliedOnDate = "AppliedOnDate"
        case className = "ClassName"
        case admissionStatus = "AdmissionStatus"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        schoolName = try container.decodeIfPresent(String.self, forKey: .schoolName) ?? ""
        appliedOnDate = try container.decodeIfPresent(String.self, forKey: .appliedOnDate)
        className = try container.decodeIfPresent(String.self, forKey: .className) ?? ""
        admissionStatus = try container.decodeIfPresent(String.self, forKey: .admissionStatus) ?? "Pending"
    }
}

struct SchoolSocialMediaInfo: Codable {
    var id: Int?
    var AccountTypeID: Int?
    var RelID: Int?
    var SocialMediaLink: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case AccountTypeID = "AccountTypeID"
        case RelID = "RelID"
        case SocialMediaLink = "SocialMediaLink"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        AccountTypeID = try container.decodeIfPresent(Int.self, forKey: .AccountTypeID) ?? -1
        RelID = try container.decodeIfPresent(Int.self, forKey: .RelID) ?? -1
        SocialMediaLink = try container.decodeIfPresent(String.self, forKey: .SocialMediaLink) ?? ""
    }
}

struct SchoolDetailInfo: Codable {
    let id: Int?
    let schoolId: Int?
    let schoolName: String?
    let emailAddress: String?
    let ntnNumber: String?
    let designation: String?
    let aboutText: String?
    let establishedYear: Int?
    let location: String?
    let availableSeats: Int?
    let numberOfTrainedTeachers: Int?
    let lastUpdated: String?
    let schoolTypeId: Int?
    let profileImageURL: String?
    let profileImageBytesString: String?
    let profileImageName: String?
    let hasTrainingMaterial: Bool?
    let hasAccessibilityMaterial: Bool?
    let numberOfTotalStudents: Int?
    let freeOrPaid: Int?
    let canEducate: Bool?
    let district: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case schoolId = "SchoolId"
        case schoolName = "SchoolName"
        case emailAddress = "EmailAddress"
        case ntnNumber = "NTNNumber"
        case designation = "Designation"
        case aboutText = "AboutText"
        case establishedYear = "EstablishedYear"
        case location = "Location"
        case availableSeats = "AvailableSeats"
        case numberOfTrainedTeachers = "NumberOfTrainedTeachers"
        case lastUpdated = "LastUpdated"
        case schoolTypeId = "SchoolTypeId"
        case profileImageURL = "ProfileImageURL"
        case profileImageBytesString = "ProfileImageBytesString"
        case profileImageName = "ProfileImageName"
        case hasTrainingMaterial = "HasTrainingMaterial"
        case hasAccessibilityMaterial = "HasAccessibilityMaterial"
        case numberOfTotalStudents = "NumberOfTotalStudents"
        case freeOrPaid = "FreeOrPaid"
        case canEducate = "CanEducate"
        case district = "District"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decoding and providing default values if key is missing or nil
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        schoolId = try container.decodeIfPresent(Int.self, forKey: .schoolId) ?? -1
        schoolName = try container.decodeIfPresent(String.self, forKey: .schoolName) ?? ""
        emailAddress = try container.decodeIfPresent(String.self, forKey: .emailAddress) ?? ""
        ntnNumber = try container.decodeIfPresent(String.self, forKey: .ntnNumber) ?? ""
        designation = try container.decodeIfPresent(String.self, forKey: .designation) ?? ""
        aboutText = try container.decodeIfPresent(String.self, forKey: .aboutText) ?? "N/A"
        establishedYear = try container.decodeIfPresent(Int.self, forKey: .establishedYear) ?? 0
        location = try container.decodeIfPresent(String.self, forKey: .location) ?? ""
        availableSeats = try container.decodeIfPresent(Int.self, forKey: .availableSeats) ?? 0
        numberOfTrainedTeachers = try container.decodeIfPresent(Int.self, forKey: .numberOfTrainedTeachers) ?? 0
        lastUpdated = try container.decodeIfPresent(String.self, forKey: .lastUpdated) ?? ""
        schoolTypeId = try container.decodeIfPresent(Int.self, forKey: .schoolTypeId) ?? 0
        profileImageURL = try container.decodeIfPresent(String.self, forKey: .profileImageURL) ?? ""
        profileImageBytesString = try container.decodeIfPresent(String.self, forKey: .profileImageBytesString) ?? ""
        profileImageName = try container.decodeIfPresent(String.self, forKey: .profileImageName) ?? ""
        hasTrainingMaterial = try container.decodeIfPresent(Bool.self, forKey: .hasTrainingMaterial) ?? false
        hasAccessibilityMaterial = try container.decodeIfPresent(Bool.self, forKey: .hasAccessibilityMaterial) ?? false
        numberOfTotalStudents = try container.decodeIfPresent(Int.self, forKey: .numberOfTotalStudents) ?? 0
        freeOrPaid = try container.decodeIfPresent(Int.self, forKey: .freeOrPaid) ?? 0
        canEducate = try container.decodeIfPresent(Bool.self, forKey: .canEducate) ?? false
        district = try container.decodeIfPresent(String.self, forKey: .district) ?? ""
    }
}
