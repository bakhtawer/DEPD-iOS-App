//
//  User.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 06/07/2024.
//

import Foundation

struct User: Codable {
    
   var cNIC: String?
   var userPassword:  String?
   var userId: Int?
   var userTypeId: Int?
   var firstName: String?
   var lastName: String?
   var contactNo: String?
   var isVerified: Bool?
    
    enum CodingKeys: String, CodingKey {
        case cNIC = "CNIC"
        case userPassword = "Password"
        case userId = "Id"
        case userTypeId = "UserTypeId"
        case firstName = "FirstName"
        case lastName = "LastName"
        case contactNo = "ContactNo"
        case isVerified = "IsVerified"
    }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            cNIC = try values.decodeIfPresent(String.self, forKey: .cNIC) ?? ""
            userPassword = try values.decodeIfPresent(String.self, forKey: .userPassword) ?? ""
            userId = try values.decodeIfPresent(Int.self, forKey: .userId) ?? -1
            userTypeId = try values.decodeIfPresent(Int.self, forKey: .userTypeId)  ?? -1
            firstName = try values.decodeIfPresent(String.self, forKey: .firstName) ?? nil
            lastName = try values.decodeIfPresent(String.self, forKey: .lastName) ?? nil
            contactNo = try values.decodeIfPresent(String.self, forKey: .contactNo) ?? ""
            isVerified = try values.decodeIfPresent(Bool.self, forKey: .isVerified) ?? nil
            
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    init() {}
}
