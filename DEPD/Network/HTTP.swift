//
//  HTTP.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 26/05/2024.
//

import Foundation

enum HTTP {
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum Headers {
        
        enum Key: String {
            case contentType = "Content-Type"
            case authorization = "Authorization"
        }
        
        enum Value: String {
            case applicationJson = "application/json"
            case authorization = ""
        }
    }
}
