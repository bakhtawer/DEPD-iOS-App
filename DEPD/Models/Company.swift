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
