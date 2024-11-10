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
    
    init() {}
}

