//
//  InstituteHomeModel.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 14/09/2024.
//

import Foundation


struct InstituteHomeModel: Codable, Hashable {
    var idMain = UUID()
    
    var SchoolId: Int?
    var InstituteHomeModelId: Int?
    var StudentId: Int?
    var AppliedOnDate: String?
    var AdmissionDate: String?
    var FormattedAppliedOnDate: String?
    var FormattedAdmissionDate: String?
    var AdmissionStatusId: Int?
    var instituteClass: String?
    var Fees: String?
    var SlipURL: String?
    var DisabilityCertificateURL: String?
    var DisabilityName: String?
    var Gender: String?
    var District: String?
    var SlipName: String?
    var SlipByte: String?
    var Reason: String?
    var ProfileCompletion: Float?
    var student: InstituteStudent?
    var ProfilePictureURL: String?
    
    enum CodingKeys: String, CodingKey {
        case idMain
        case SchoolId = "SchoolId"
        case InstituteHomeModelId = "Id"
        case StudentId = "StudentId"
        case AppliedOnDate = "AppliedOnDate"
        case AdmissionDate = "AdmissionDate"
        case FormattedAppliedOnDate = "FormattedAppliedOnDate"
        case FormattedAdmissionDate = "FormattedAdmissionDate"
        case AdmissionStatusId = "AdmissionStatusId"
        case instituteClass = "Class"
        case Fees = "Fees"
        case SlipURL = "SlipURL"
        case DisabilityCertificateURL = "DisabilityCertificateURL"
        case DisabilityName = "DisabilityName"
        case Gender = "Gender"
        case District = "District"
        case SlipName = "SlipName"
        case SlipByte = "SlipByte"
        case Reason = "Reason"
        case ProfileCompletion = "ProfileCompletion"
        case student = "User"
        case ProfilePictureURL = "ProfilePictureURL"
    }
    
    init(from decoder: Decoder) throws {
        do {
            idMain = UUID()
            let values = try decoder.container(keyedBy: CodingKeys.self)
            InstituteHomeModelId = try values.decodeIfPresent(Int.self, forKey: .InstituteHomeModelId) ?? -1
            StudentId = try values.decodeIfPresent(Int.self, forKey: .StudentId) ??  -1
            AppliedOnDate = try values.decodeIfPresent(String.self, forKey: .AppliedOnDate) ??  ""
            AdmissionDate = try values.decodeIfPresent(String.self, forKey: .AdmissionDate) ??  ""
            FormattedAppliedOnDate = try values.decodeIfPresent(String.self, forKey: .FormattedAppliedOnDate) ?? ""
            FormattedAdmissionDate = try values.decodeIfPresent(String.self, forKey:.FormattedAdmissionDate) ?? ""
            AdmissionStatusId = try values.decodeIfPresent(Int.self, forKey: .AdmissionStatusId) ?? -1
            instituteClass = try values.decodeIfPresent(String.self, forKey: .instituteClass) ??  ""
            Fees = try values.decodeIfPresent(String.self, forKey: .Fees) ??  ""
            SlipURL = try values.decodeIfPresent(String.self, forKey: .SlipURL) ??  ""
            DisabilityCertificateURL = try values.decodeIfPresent(String.self, forKey: .DisabilityCertificateURL) ?? ""
            DisabilityName = try values.decodeIfPresent(String.self, forKey: .DisabilityName) ??  ""
            Gender = try values.decodeIfPresent(String.self, forKey: .Gender) ??  ""
            District = try values.decodeIfPresent(String.self, forKey: .District) ??  ""
            SlipName = try values.decodeIfPresent(String.self, forKey: .SlipName) ??  ""
            SlipByte = try values.decodeIfPresent(String.self, forKey: .SlipByte) ??  ""
            Reason = try values.decodeIfPresent(String.self, forKey: .Reason) ??  ""
            ProfileCompletion = try values.decodeIfPresent(Float.self, forKey: .ProfileCompletion) ?? 0
            student = try values.decodeIfPresent(InstituteStudent.self, forKey: .student)
            ProfilePictureURL = try values.decodeIfPresent(String.self, forKey: .ProfilePictureURL) ??  ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    static func == (lhs: InstituteHomeModel, rhs: InstituteHomeModel) -> Bool {
        return  lhs.idMain == rhs.idMain
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(idMain)
    }
}

struct InstituteStudent: Codable {
    var idMain = UUID()
    var InstituteStudentId: Int?
    var UserTypeId: Int?
    var FirstName: String?
    var LastName: String?
    var CNIC: String?
    var ContactNo: String?
    var Password: String?
    var IsVerified: Bool?
    
    enum CodingKeys: String, CodingKey {
        case InstituteStudentId = "Id"
        case UserTypeId = "UserTypeId"
        case FirstName = "FirstName"
        case LastName = "LastName"
        case CNIC = "CNIC"
        case ContactNo = "ContactNo"
        case Password = "Password"
        case IsVerified = "IsVerified"
    }
    init(from decoder: Decoder) throws {
        do {
            idMain = UUID()
            let values = try decoder.container(keyedBy: CodingKeys.self)
            
            InstituteStudentId = try values.decodeIfPresent(Int.self, forKey: .InstituteStudentId) ?? -1
            UserTypeId = try values.decodeIfPresent(Int.self, forKey: .UserTypeId) ?? -1
            FirstName = try values.decodeIfPresent(String.self, forKey: .FirstName) ?? ""
            LastName = try values.decodeIfPresent(String.self, forKey: .LastName)  ?? ""
            CNIC = try values.decodeIfPresent(String.self, forKey: .CNIC) ?? ""
            ContactNo = try values.decodeIfPresent(String.self, forKey: .ContactNo) ?? ""
            Password = try values.decodeIfPresent(String.self, forKey: .Password) ?? ""
            IsVerified = try values.decodeIfPresent(Bool.self, forKey: .IsVerified) ?? false
            
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    static func == (lhs: InstituteStudent, rhs: InstituteStudent) -> Bool {
        return  lhs.idMain == rhs.idMain
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(idMain)
    }
}
