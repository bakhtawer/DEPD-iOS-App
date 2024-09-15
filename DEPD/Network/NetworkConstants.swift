//
//  NetworkConstants.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 26/05/2024.
//

import Foundation

struct NetworkConstants {
    
    // MARK: - API
    static let scheme = "https"
    static let baseURL = "hub.depdportal.com"
    static let port: Int? = nil // If there's no specific port, keep it nil
}

//"dped.pppsforepi.com/api"
//let request = Endpoint.fetchPosts().request!
//
//service.makeRequest(with: request, respModel: [Post].self) { posts, error in
//    if let error = error { print("DEBUG PRINT:", error); return }
//    
//    posts?.forEach({
//        print($0.title)
//    })
//}
