//
//  Student.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 07/07/2024.
//

import Foundation

struct Student: Codable {
    
    var studentId : Int?
    var fatherName : String?
    var fatherCNIC : String?
    var dOB : String?
    var gender : String?
    var address : String?
    var district : String?
    var disabilityStatusId : Int?
    var previousEducation : String?
    var profilePictureURL : String?
    var profilePictureBytesString : String?
    var profilePictureName : String?
    var disabilityCertificateURL : String?
    var disabilityCertBytesString : String?
    var disabilityCertName : String?
    var hasPPUploaded : Bool?
    var hasDisCertUploaded : Bool?
    
    
    enum CodingKeys: String, CodingKey {
        case studentId = "Id"
        case fatherName = "FatherName"
        case fatherCNIC = "FatherCNIC"
        case dOB = "DOB"
        case gender = "Gender"
        case address = "Address"
        case district = "District"
        case disabilityStatusId = "DisabilityStatusId"
        case previousEducation = "PreviousEducation"
        case profilePictureURL = "ProfilePictureURL"
        case profilePictureBytesString = "ProfilePictureBytesString"
        case profilePictureName = "ProfilePictureName"
        case disabilityCertificateURL = "DisabilityCertificateURL"
        case disabilityCertBytesString = "DisabilityCertBytesString"
        case disabilityCertName = "DisabilityCertName"
        case hasPPUploaded = "HasPPUploaded"
        case hasDisCertUploaded = "HasDisCertUploaded"
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            studentId = try values.decodeIfPresent(Int.self, forKey: .studentId) ?? -1
            fatherName = try values.decodeIfPresent(String.self, forKey: .fatherName) ?? ""
            fatherCNIC = try values.decodeIfPresent(String.self, forKey: .fatherCNIC) ?? ""
            dOB = try values.decodeIfPresent(String.self, forKey: .dOB) ?? ""
            gender = try values.decodeIfPresent(String.self, forKey: .gender) ?? ""
            address = try values.decodeIfPresent(String.self, forKey: .address) ?? ""
            district = try values.decodeIfPresent(String.self, forKey: .district) ?? ""
            disabilityStatusId = try values.decodeIfPresent(Int.self, forKey: .disabilityStatusId) ?? -1
            previousEducation = try values.decodeIfPresent(String.self, forKey: .previousEducation) ?? ""
            profilePictureURL = try values.decodeIfPresent(String.self, forKey: .profilePictureURL) ?? ""
            profilePictureBytesString = try values.decodeIfPresent(String.self, forKey: .profilePictureBytesString) ?? ""
            profilePictureName = try values.decodeIfPresent(String.self, forKey: .profilePictureName) ?? ""
            disabilityCertificateURL = try values.decodeIfPresent(String.self, forKey: .disabilityCertificateURL) ?? ""
            disabilityCertBytesString = try values.decodeIfPresent(String.self, forKey: .disabilityCertBytesString) ?? ""
            disabilityCertName = try values.decodeIfPresent(String.self, forKey: .disabilityCertName) ?? ""
            hasPPUploaded = try values.decodeIfPresent(Bool.self, forKey: .hasPPUploaded) ?? false
            hasDisCertUploaded = try values.decodeIfPresent(Bool.self, forKey: .hasDisCertUploaded) ?? false
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
