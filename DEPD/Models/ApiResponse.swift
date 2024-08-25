//
//  ApiResponse.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 06/07/2024.
//

import Foundation

public class ApiResponse<T>: Codable where T: Codable {
    var oData: T?
    var isError: Bool?
    var errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case oData = "oData"
        case isError = "IsError"
        case errorMessage = "ErrorMessage"
    }
    
    required public init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            oData = try values.decodeIfPresent(T.self, forKey: .oData)
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
