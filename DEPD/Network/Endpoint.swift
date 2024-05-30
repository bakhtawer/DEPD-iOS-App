//
//  Endpoint.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 26/05/2024.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

enum Endpoint {
    
    case fetchPosts(url: String = "/posts")
    case fetchOnePost(url: String = "/posts", postId: Int = 1)
    case sendPost(url: String = "/posts", post: Post)
    
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.httpBody = self.httpBody
        request.addValues(for: self)
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = NetworkConstants.scheme
        components.host = NetworkConstants.baseURL
        components.port = NetworkConstants.port
        components.path = self.path
        components.queryItems = self.queryItems
        return components.url
    }
    
    private var path: String {
        switch self {
        case .fetchPosts(let url): return url
        case .fetchOnePost(let url, let postId): return "\(url)/\(postId.description)"
        case .sendPost(let url, _): return url
        }
    }
    
    
    private var queryItems: [URLQueryItem] {
        switch self {
            default: return []
        }
    }
    
    
    private var httpMethod: String {
        switch self {
        case .fetchPosts,
             .fetchOnePost:
            return HTTP.Method.get.rawValue
        case .sendPost:
            return HTTP.Method.post.rawValue
        }
    }
    
    private var httpBody: Data? {
        switch self {
        case .fetchPosts,
             .fetchOnePost:
            return nil
        case .sendPost(_, let post):
            let jsonPost = try? JSONEncoder().encode(post)
            return jsonPost
        }
    }
}

extension URLRequest {
    
    mutating func addValues(for endpoint: Endpoint) {
        switch endpoint {
        case .fetchPosts,
             .fetchOnePost:
            break
        case .sendPost:
            self.setValue(
                HTTP.Headers.Value.applicationJson.rawValue,
                forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue
            )
        }
    }
}
