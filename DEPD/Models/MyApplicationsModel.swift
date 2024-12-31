//
//  MyApplicationsModel.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 30/12/2024.
//

import Foundation

struct MyApplicationsModel: Codable, Hashable {
    var idMain = UUID()
    var ID: Int?
    var SchoolName: String?
    var AppliedOnDate: String?
    var Classname: String?
    var ApplicationsStatus: String?
    
    enum CodingKeys: String, CodingKey {
        case idMain
        case ID
        case SchoolName
        case AppliedOnDate
        case Classname
        case ApplicationsStatus
    }

    init(from decoder: Decoder) throws {
        do {
            idMain = UUID()
            let container = try decoder.container(keyedBy: CodingKeys.self)
            ID = try container.decodeIfPresent(Int.self, forKey: .ID) ?? -1
            SchoolName = try container.decodeIfPresent(String.self, forKey: .SchoolName) ?? ""
            AppliedOnDate = try container.decodeIfPresent(String.self, forKey: .AppliedOnDate) ?? ""
            ApplicationsStatus = try container.decodeIfPresent(String.self, forKey: .ApplicationsStatus) ?? ""
            Classname = try container.decodeIfPresent(String.self, forKey: .Classname) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    static func == (lhs: MyApplicationsModel, rhs: MyApplicationsModel) -> Bool {
        return  lhs.idMain == rhs.idMain
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(idMain)
    }
}
