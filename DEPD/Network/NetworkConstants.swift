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
    static let baseURL = "github.com/iamCodeBrah/Swift-Generic-API-Calls/blob/Finished/GenericAPITutorial/ViewController.swift"
    static let port: Int? = nil
}

//let request = Endpoint.fetchPosts().request!
//
//service.makeRequest(with: request, respModel: [Post].self) { posts, error in
//    if let error = error { print("DEBUG PRINT:", error); return }
//    
//    posts?.forEach({
//        print($0.title)
//    })
//}
