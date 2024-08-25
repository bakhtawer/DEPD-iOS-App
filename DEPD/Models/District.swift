//
//  District.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 25/08/2024.
//

import Foundation

struct District: Codable {
    var districtId : Int?
    var name : String?
    enum CodingKeys: String, CodingKey {
        case districtId = "Id"
        case name = "name"
    }
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            districtId = try values.decodeIfPresent(Int.self, forKey: .districtId) ?? -1
            name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct Disability: Codable {
    var disabilityId : Int?
    var name : String?
    enum CodingKeys: String, CodingKey {
        case disabilityId = "Id"
        case name = "DisabilityName"
    }
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            disabilityId = try values.decodeIfPresent(Int.self, forKey: .disabilityId) ?? -1
            name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct Gender: Codable {
    var genderId : Int?
    var name : String?
    enum CodingKeys: String, CodingKey {
        case genderId = "Id"
        case name = "GenderName"
    }
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            genderId = try values.decodeIfPresent(Int.self, forKey: .genderId) ?? -1
            name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct Designations: Codable {
    var designationId : Int?
    var name : String?
    enum CodingKeys: String, CodingKey {
        case designationId = "Id"
        case name = "DesignationName"
    }
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            designationId = try values.decodeIfPresent(Int.self, forKey: .designationId) ?? -1
            name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
