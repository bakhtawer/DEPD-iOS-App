//
//  JobSeeker.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 13/10/2024.
//

import Foundation

struct JobSeekerModel: Codable, Hashable {
    
    var idMain = UUID()
    var jobID: Int?
    var UserID: Int?
    var Name:String?
    var Address:String?
    var DisabilityId:String?
    var DisabilityName:String?
    var Age:String?
    var DisabilityCertificateURL:String?
    var ProfilePicture:String?
    var ProfilePictureBytesString:String?
    var ProfilePictureName:String?
    var Gender:Int?
    var SearchTags:String?
    var DateOfBirth:String?
    var District:String?
    var EmailAddress:String?
    var CVFileUploadName:String?
    var CVFileUploadByteString:String?
    var DisabilityCertificateName:String?
    var DisabilityCertificateByteString:String?
    var jobseeker: JobSeeker?

    enum CodingKeys: String, CodingKey {
        case idMain
        case jobID = "ID"
        case UserID = "UserID"
        case Name = "Name"
        case Address = "Address"
        case DisabilityId = "DisabilityId"
        case DisabilityName = "DisabilityName"
        case Age = "Age"
        case DisabilityCertificateURL = "DisabilityCertificateURL"
        case ProfilePicture = "ProfilePicture"
        case ProfilePictureBytesString = "ProfilePictureBytesString"
        case ProfilePictureName = "ProfilePictureName"
        case Gender = "Gender"
        case SearchTags = "SearchTags"
        case DateOfBirth = "DateOfBirth"
        case District = "District"
        case EmailAddress = "EmailAddress"
        case CVFileUploadName = "CVFileUploadName"
        case CVFileUploadByteString = "CVFileUploadByteString"
        case DisabilityCertificateName = "DisabilityCertificateName"
        case DisabilityCertificateByteString = "DisabilityCertificateByteString"
        case jobseeker = "oUser"
    }
    
    init(from decoder: Decoder) throws {
        do {
            idMain = UUID()
            let values = try decoder.container(keyedBy: CodingKeys.self)
            jobID = try values.decodeIfPresent(Int.self, forKey: .jobID) ?? -1
            UserID = try values.decodeIfPresent(Int.self, forKey: .UserID) ?? -1
            Name = try values.decodeIfPresent(String.self, forKey: .Name) ??  ""
            Address = try values.decodeIfPresent(String.self, forKey: .Address) ??  ""
            DisabilityId = try values.decodeIfPresent(String.self, forKey: .DisabilityId) ??  ""
            DisabilityName = try values.decodeIfPresent(String.self, forKey: .DisabilityName) ??  ""
            Age = try values.decodeIfPresent(String.self, forKey: .Age) ??  ""
            DisabilityCertificateURL = try values.decodeIfPresent(String.self, forKey: .DisabilityCertificateURL) ??  ""
            ProfilePicture = try values.decodeIfPresent(String.self, forKey: .ProfilePicture) ??  ""
            ProfilePictureBytesString = try values.decodeIfPresent(String.self, forKey: .ProfilePictureBytesString) ??  ""
            ProfilePictureName = try values.decodeIfPresent(String.self, forKey: .ProfilePictureName) ??  ""
            Gender = try values.decodeIfPresent(Int.self, forKey: .Gender) ?? 0
            SearchTags = try values.decodeIfPresent(String.self, forKey: .SearchTags) ??  ""
            DateOfBirth = try values.decodeIfPresent(String.self, forKey: .DateOfBirth) ??  ""
            District = try values.decodeIfPresent(String.self, forKey: .District) ??  ""
            EmailAddress = try values.decodeIfPresent(String.self, forKey: .EmailAddress) ??  ""
            CVFileUploadName = try values.decodeIfPresent(String.self, forKey: .CVFileUploadName) ??  ""
            CVFileUploadByteString = try values.decodeIfPresent(String.self, forKey: .CVFileUploadByteString) ??  ""
            DisabilityCertificateName = try values.decodeIfPresent(String.self, forKey: .DisabilityCertificateName) ??  ""
            DisabilityCertificateByteString = try values.decodeIfPresent(String.self, forKey: .DisabilityCertificateByteString) ??  ""

            jobseeker = try values.decodeIfPresent(JobSeeker.self, forKey: .jobseeker)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    init() {
        idMain = UUID()
        
        self.jobseeker?.FirstName = "Ali Rehman"
        self.DisabilityName = "Disability Status"
        self.Age = "30"
        self.Gender = 1
        self.District = "Town, Peshawar"
        
    }
    
    static func == (lhs: JobSeekerModel, rhs: JobSeekerModel) -> Bool {
        return  lhs.idMain == rhs.idMain
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(idMain)
    }
}


struct JobSeeker: Codable {
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
            IsVerified = try values.decodeIfPresent(Bool.self, forKey: .IsVerified) ?? false
            
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    init() {
        idMain = UUID()
        self.FirstName = "Hello world"
    }
    
    static func == (lhs: JobSeeker, rhs: JobSeeker) -> Bool {
        return  lhs.idMain == rhs.idMain
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(idMain)
    }
}
