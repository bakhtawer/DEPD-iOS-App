//
//  Company.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 13/10/2024.
//

import Foundation

struct CompanyModel: Codable, Hashable {
    
    var idMain = UUID()
    var idid: Int?
    var CompanyId: Int?
    var CompanyName: String?
    var PositionName: String?
    var CompanyImageURL: String?
    var applyForJobUrl: String?
    var Salary: String?
    var PostedOnDate: String?
    var PostedOnDateString: String?
    var RequiredExperience: Int?
    var StatusId: Int?
    var StatusName: String?
    var DescriptionText: String?
    var NoOfVaccancies: Int?
    var Location: String?
    var ThumbnailImageURL: String?
    var subTypeId: String?
    var disabilityStatusId: String?
    var distict: String?
    
    enum CodingKeys: String, CodingKey {
        case idMain
        case idid = "Id"
        case CompanyId = "CompanyId"
        case CompanyName = "CompanyName"
        case PositionName = "PositionName"
        case CompanyImageURL = "CompanyImageURL"
        case applyForJobUrl = "applyForJobUrl"
        case Salary = "Salary"
        case PostedOnDate = "PostedOnDate"
        case PostedOnDateString = "PostedOnDateString"
        case RequiredExperience = "RequiredExperience"
        case StatusId = "StatusId"
        case StatusName = "StatusName"
        case DescriptionText = "DescriptionText"
        case NoOfVaccancies = "NoOfVaccancies"
        case Location = "Location"
        case ThumbnailImageURL = "ThumbnailImageURL"
        case subTypeId = "SubTypeId"
        case disabilityStatusId = "DisabilityStatusId"
        case distict = "Distict"
    }
    
    init(from decoder: Decoder) throws {
        do {
            idMain = UUID()
            let values = try decoder.container(keyedBy: CodingKeys.self)
            idid = try values.decodeIfPresent(Int.self, forKey: .idid) ?? -1
            CompanyId = try values.decodeIfPresent(Int.self, forKey: .CompanyId) ?? -1
            CompanyName = try values.decodeIfPresent(String.self, forKey: .CompanyName) ?? ""
            PositionName = try values.decodeIfPresent(String.self, forKey: .PositionName) ?? ""
            CompanyImageURL = try values.decodeIfPresent(String.self, forKey: .CompanyImageURL) ?? ""
            applyForJobUrl = try values.decodeIfPresent(String.self, forKey: .applyForJobUrl) ?? ""
            Salary = try values.decodeIfPresent(String.self, forKey: .Salary) ?? ""
            PostedOnDate = try values.decodeIfPresent(String.self, forKey: .PostedOnDate) ?? ""
            PostedOnDateString = try values.decodeIfPresent(String.self, forKey: .PostedOnDateString) ?? ""
            RequiredExperience = try values.decodeIfPresent(Int.self, forKey: .RequiredExperience) ?? 0
            StatusId = try values.decodeIfPresent(Int.self, forKey: .StatusId) ?? -1
            StatusName = try values.decodeIfPresent(String.self, forKey: .StatusName) ?? ""
            DescriptionText = try values.decodeIfPresent(String.self, forKey: .DescriptionText) ?? "N/A"
            NoOfVaccancies = try values.decodeIfPresent(Int.self, forKey: .NoOfVaccancies) ?? 0
            Location = try values.decodeIfPresent(String.self, forKey: .Location) ?? ""
            ThumbnailImageURL = try values.decodeIfPresent(String.self, forKey: .ThumbnailImageURL) ?? ""
            distict = try values.decodeIfPresent(String.self, forKey: .distict) ?? ""
            subTypeId = try values.decodeIfPresent(String.self, forKey: .subTypeId) ?? "-1"
            disabilityStatusId = try values.decodeIfPresent(String.self, forKey: .disabilityStatusId) ?? "-1"
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    static func == (lhs: CompanyModel, rhs: CompanyModel) -> Bool {
        return  lhs.idMain == rhs.idMain
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(idMain)
    }
}

struct CompanyJobModel: Codable, Hashable {
    var idMain = UUID()
    var Id: Int?
    var FirstName: String?
    var LastName: String?
    var StatusName: String?
    var Address: String?
    var Age: Int?
    var StatusId: Int?
    var dob: String?
    var ContactNo: String?
    var profilePicture: String?
    
    enum CodingKeys: String, CodingKey {
        case idMain
        case Id = "Id"
        case FirstName = "FirstName"
        case LastName = "LastName"
        case StatusName = "StatusName"
        case Address = "Address"
        case Age = "Age"
        case StatusId = "StatusId"
        case dob = "DateofBirth"
        case ContactNo = "ContactNo"
        case profilePicture = "profilePicture"
    }
    
    init(from decoder: Decoder) throws {
        do {
            idMain = UUID()
            let values = try decoder.container(keyedBy: CodingKeys.self)
            Id = try values.decodeIfPresent(Int.self, forKey: .Id) ?? -1
            FirstName = try values.decodeIfPresent(String.self, forKey: .FirstName) ?? ""
            LastName = try values.decodeIfPresent(String.self, forKey: .LastName) ?? ""
            StatusName = try values.decodeIfPresent(String.self, forKey: .StatusName) ?? ""
            Address = try values.decodeIfPresent(String.self, forKey: .Address) ?? ""
            Age = try values.decodeIfPresent(Int.self, forKey: .Age) ?? 0
            StatusId = try values.decodeIfPresent(Int.self, forKey: .StatusId) ?? -1
            dob = try values.decodeIfPresent(String.self, forKey: .dob) ?? ""
            ContactNo = try values.decodeIfPresent(String.self, forKey: .ContactNo) ?? ""
            profilePicture = try values.decodeIfPresent(String.self, forKey: .profilePicture) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    static func == (lhs: CompanyJobModel, rhs: CompanyJobModel) -> Bool {
        return  lhs.idMain == rhs.idMain
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(idMain)
    }
}


struct CompanyVacancyModel: Codable, Hashable {
    var idMain = UUID()
    var CompanyId: Int?
    var CompanyName: String?
    var Description: String?
    var ThumbnailImageURL: String?
    var NumOfVaccancies: String?
    var Position: String?
    var PostedOnDate: String?
    
    enum CodingKeys: String, CodingKey {
        case idMain
        case CompanyId
        case CompanyName
        case Description
        case ThumbnailImageURL
        case NumOfVaccancies
        case Position
        case PostedOnDate
    }
    
    init(from decoder: Decoder) throws {
        do {
            idMain = UUID()
            let values = try decoder.container(keyedBy: CodingKeys.self)
            CompanyId = try values.decodeIfPresent(Int.self, forKey: .CompanyId) ?? -1
            CompanyName = try values.decodeIfPresent(String.self, forKey: .CompanyName) ?? ""
            Description = try values.decodeIfPresent(String.self, forKey: .Description) ?? ""
            ThumbnailImageURL = try values.decodeIfPresent(String.self, forKey: .ThumbnailImageURL) ?? ""
            NumOfVaccancies = try values.decodeIfPresent(String.self, forKey: .NumOfVaccancies) ?? ""
            Position = try values.decodeIfPresent(String.self, forKey: .Position) ?? ""
            PostedOnDate = try values.decodeIfPresent(String.self, forKey: .PostedOnDate) ?? ""
            
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    static func == (lhs: CompanyVacancyModel, rhs: CompanyVacancyModel) -> Bool {
        return  lhs.idMain == rhs.idMain
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(idMain)
    }
}

struct CompanyEmployeeModel: Codable, Hashable {
    var ID:Int?
    var UserID:Int?
    var Name:String?
    var Address:String?
    var Age:Int?
    var DisabilityId:Int?
    var DisabilityName:String?
    var EmailAddress:String?
    var ProfilePicture:String?
    var idMain = UUID()
    
    enum CodingKeys: String, CodingKey {
        case idMain
        case ID = "ID"
        case UserID = "UserID"
        case Name = "Name"
        case Address = "Address"
        case Age = "Age"
        case DisabilityId = "DisabilityId"
        case DisabilityName = "DisabilityName"
        case EmailAddress = "EmailAddress"
        case ProfilePicture = "ProfilePicture"
    }
    
    init(from decoder: Decoder) throws {
        do {
            idMain = UUID()
            let values = try decoder.container(keyedBy: CodingKeys.self)
            ID = try values.decodeIfPresent(Int.self, forKey: .ID) ?? -1
            UserID = try values.decodeIfPresent(Int.self, forKey: .UserID) ?? 0
            Name = try values.decodeIfPresent(String.self, forKey: .Name) ?? ""
            Address = try values.decodeIfPresent(String.self, forKey: .Address) ?? ""
            Age = try values.decodeIfPresent(Int.self, forKey: .Age) ?? 0
            DisabilityId = try values.decodeIfPresent(Int.self, forKey: .DisabilityId) ?? 0
            DisabilityName = try values.decodeIfPresent(String.self, forKey: .DisabilityName) ?? ""
            EmailAddress = try values.decodeIfPresent(String.self, forKey: .EmailAddress) ?? ""
            ProfilePicture = try values.decodeIfPresent(String.self, forKey: .ProfilePicture) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    static func == (lhs: CompanyEmployeeModel, rhs: CompanyEmployeeModel) -> Bool {
        return  lhs.idMain == rhs.idMain
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(idMain)
    }
}
