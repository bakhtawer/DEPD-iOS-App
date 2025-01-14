//
//  MyApplicationsModel.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 30/12/2024.
//

import Foundation

class MyApplicationsContainer: Codable {
    var oData: [MyApplicationsModel]?
    var isError: Bool?
    var errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case oData = "ApplicationList"
        case isError = "IsError"
        case errorMessage = "ErrorMessage"
    }
    
    required public init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            oData = try values.decodeIfPresent([MyApplicationsModel].self, forKey: .oData)
            isError = try values.decodeIfPresent(Bool.self, forKey: .isError)
            errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct MyApplicationsModel: Codable, Hashable {
    var idMain = UUID()
    var ID: Int?
    var SchoolName: String?
    var AppliedOnDate: String?
    var ClassName: String?
    var AdmissionStatus: String?
    
    enum CodingKeys: String, CodingKey {
        case idMain
        case ID
        case SchoolName
        case AppliedOnDate
        case ClassName
        case AdmissionStatus
    }

    init(from decoder: Decoder) throws {
        do {
            idMain = UUID()
            let container = try decoder.container(keyedBy: CodingKeys.self)
            ID = try container.decodeIfPresent(Int.self, forKey: .ID) ?? -1
            SchoolName = try container.decodeIfPresent(String.self, forKey: .SchoolName) ?? ""
            AppliedOnDate = try container.decodeIfPresent(String.self, forKey: .AppliedOnDate) ?? ""
            AdmissionStatus = try container.decodeIfPresent(String.self, forKey: .AdmissionStatus) ?? ""
            ClassName = try container.decodeIfPresent(String.self, forKey: .ClassName) ?? ""
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
