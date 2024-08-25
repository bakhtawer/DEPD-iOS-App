//
//  School.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 25/08/2024.
//

import Foundation

struct InstituteModel: Codable, Hashable {
    var idMain = UUID()
    var InstituteId: Int?
    var SchoolName: String?
    var ImageURL: String?
    var applyForSchoolUrl: String?
    var NumberOfSeats: Int?
    var EmailAddress: String?
    var ContactNumber: String?
    var NTNNUmber: String?
    var Designation: String?
    var AboutText: String?
    var Location: String?
    var EstablishedYear: Int?
    var NumOfTrainedTeachers: Int?
    var SchoolTypeId: Int?
    var SchoolTypeName: String?
    var HasAccessibilityMaterial: Bool?
    var HasTrainingMaterial: Bool?
    var LastUpdated: String?
    var FormattedLastUpdated: String?
    var FreeOrPaid: Int?
    var SchoolMultiMediaList: [SchoolMultiMedia]?
    var DisabilityStatusList: [Disability]?
    var SchoolDisabilityList: [SchoolDisability]?
    
    
    enum CodingKeys: String, CodingKey {
        case idMain
        case InstituteId = "Id"
        case SchoolName = "SchoolName"
        case ImageURL = "ImageURL"
        case applyForSchoolUrl = "applyForSchoolUrl"
        case NumberOfSeats = "NumberOfSeats"
        case EmailAddress = "EmailAddress"
        case ContactNumber = "ContactNumber"
        case NTNNUmber = "NTNNUmber"
        case Designation = "Designation"
        case AboutText = "AboutText"
        case Location = "Location"
        case EstablishedYear = "EstablishedYear"
        case NumOfTrainedTeachers = "NumOfTrainedTeachers"
        case SchoolTypeId = "SchoolTypeId"
        case SchoolTypeName = "SchoolTypeName"
        case HasAccessibilityMaterial = "HasAccessibilityMaterial"
        case HasTrainingMaterial = "HasTrainingMaterial"
        case LastUpdated = "LastUpdated"
        case FormattedLastUpdated = "FormattedLastUpdated"
        case FreeOrPaid = "FreeOrPaid"
        case SchoolMultiMediaList = "oSchoolMultiMediaList"
        case DisabilityStatusList = "oDisabilityStatusList"
        case SchoolDisabilityList = "oSchoolDisabilityList"
    }
    
    init(from decoder: Decoder) throws {
        do {
            idMain = UUID()
            let values = try decoder.container(keyedBy: CodingKeys.self)
            InstituteId = try values.decodeIfPresent(Int.self, forKey: .InstituteId) ?? -1
            SchoolName = try values.decodeIfPresent(String.self, forKey: .SchoolName) ?? ""
            ImageURL = try values.decodeIfPresent(String.self, forKey: .ImageURL) ?? ""
            applyForSchoolUrl = try values.decodeIfPresent(String.self, forKey: .applyForSchoolUrl) ?? ""
            NumberOfSeats = try values.decodeIfPresent(Int.self, forKey: .NumberOfSeats) ?? -1
            EmailAddress = try values.decodeIfPresent(String.self, forKey: .EmailAddress) ?? "Email is not available"
            ContactNumber = try values.decodeIfPresent(String.self, forKey: .ContactNumber) ?? "Contact is not available"
            NTNNUmber = try values.decodeIfPresent(String.self, forKey: .NTNNUmber) ?? ""
            Designation = try values.decodeIfPresent(String.self, forKey: .Designation) ?? ""
            AboutText = try values.decodeIfPresent(String.self, forKey: .AboutText) ?? ""
            Location = try values.decodeIfPresent(String.self, forKey: .Location) ?? ""
            EstablishedYear = try values.decodeIfPresent(Int.self, forKey: .EstablishedYear) ?? -1
            NumOfTrainedTeachers = try values.decodeIfPresent(Int.self, forKey: .NumOfTrainedTeachers) ?? -1
            SchoolTypeId = try values.decodeIfPresent(Int.self, forKey: .SchoolTypeId) ?? -1
            SchoolTypeName = try values.decodeIfPresent(String.self, forKey: .SchoolTypeName) ?? ""
            HasAccessibilityMaterial = try values.decodeIfPresent(Bool.self, forKey: .HasAccessibilityMaterial) ?? false
            HasTrainingMaterial = try values.decodeIfPresent(Bool.self, forKey: .HasTrainingMaterial) ?? false
            LastUpdated = try values.decodeIfPresent(String.self, forKey: .LastUpdated) ?? ""
            FormattedLastUpdated = try values.decodeIfPresent(String.self, forKey: .FormattedLastUpdated) ?? ""
            FreeOrPaid = try values.decodeIfPresent(Int.self, forKey: .FreeOrPaid) ?? -1
            SchoolMultiMediaList = try values.decodeIfPresent([SchoolMultiMedia].self, forKey: .SchoolMultiMediaList) ?? []
            DisabilityStatusList = try values.decodeIfPresent([Disability].self, forKey: .DisabilityStatusList) ?? []
            SchoolDisabilityList = try values.decodeIfPresent([SchoolDisability].self, forKey: .SchoolDisabilityList) ?? []
            
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    static func == (lhs: InstituteModel, rhs: InstituteModel) -> Bool {
        return  lhs.idMain == rhs.idMain
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(idMain)
    }
}

struct SchoolDisability: Codable {
    var schoolDisabilityId : Int?
    var userId : Int?
    var disabilityStatusId: Int?
    enum CodingKeys: String, CodingKey {
        case schoolDisabilityId = "Id"
        case userId = "userId"
        case disabilityStatusId = "disabilityStatusId"
    }
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            schoolDisabilityId = try values.decodeIfPresent(Int.self, forKey: .schoolDisabilityId) ?? -1
            userId = try values.decodeIfPresent(Int.self, forKey: .userId) ?? -1
            disabilityStatusId = try values.decodeIfPresent(Int.self, forKey: .disabilityStatusId) ?? -1
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct SchoolMultiMedia: Codable {
    var schoolMultiMediaID : Int?
    var SchoolId : Int?
    var FileURL: String?
    var FileURLWithBaseUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case schoolMultiMediaID = "Id"
        case SchoolId = "SchoolId"
        case FileURL = "FileURL"
        case FileURLWithBaseUrl = "FileURLWithBaseUrl"
    }
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            schoolMultiMediaID = try values.decodeIfPresent(Int.self, forKey: .schoolMultiMediaID) ?? -1
            SchoolId = try values.decodeIfPresent(Int.self, forKey: .SchoolId) ?? -1
            FileURL = try values.decodeIfPresent(String.self, forKey: .FileURL) ?? ""
            FileURLWithBaseUrl = try values.decodeIfPresent(String.self, forKey: .FileURLWithBaseUrl) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
