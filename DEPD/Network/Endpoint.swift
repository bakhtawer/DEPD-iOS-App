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

struct LoginCredentials: Codable {
    let CNIC: String
    let Password: String
}

struct ApplySchool: Codable {
    let SchoolId: Int
}
 
enum Endpoint {
    
    case login(url: String = "/api/auth.ashx",
               email: String,
               password: String)
    case register(url: String = "/api/auth.ashx",
                  creds: SignUpCredentials)
    
    case getDistrict
    case getDisstatList
    case getGenders
    case getDesignations
    
    case getSchoolList
    case applyForSchool(schoolID: Int)
    
    case getStudentAdmissions(schoolID: Int)
    
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
        case .login(url: let url, _, _): return url
        case .register(let url, _): return url
        case .getDistrict, .getDisstatList, .getGenders, .getDesignations, .getStudentAdmissions: return "/Api/General.ashx"
        case .getSchoolList, .applyForSchool: return "/Api/school.ashx"
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .login: return [URLQueryItem(name: "method", value: "login")]
        case .register: return [URLQueryItem(name: "method", value: "register")]
        case .getDistrict: return [URLQueryItem(name: "method", value: "getdistrict")]
        case .getGenders: return [URLQueryItem(name: "method", value: "getgenders")]
        case .getDesignations: return [URLQueryItem(name: "method", value: "getdesignations")]
        case .getDisstatList: return [URLQueryItem(name: "method", value: "getdisstatlist")]
        case .getSchoolList: return [URLQueryItem(name: "method", value: "getSchoolList")]
        case .applyForSchool: return [URLQueryItem(name: "method", value: "applyForSchool")]
        case .getStudentAdmissions(let schoolID): return [URLQueryItem(name: "method", value: "getStudentAdmissions")]
        case .fetchPosts(url: let url): return []
        case .fetchOnePost(url: let url, postId: let postId): return []
        case .sendPost(url: let url, post: let post): return []
        }
    }
    
    private var httpMethod: String {
        switch self {
        case .fetchPosts,
             .fetchOnePost,
             .getDistrict, .getDisstatList, .getGenders, .getDesignations,
             .getSchoolList:
            return HTTP.Method.get.rawValue
        case .sendPost, .login, .register,
            .applyForSchool,
            .getStudentAdmissions:
            return HTTP.Method.post.rawValue
        }
    }
    
    private var httpBody: Data? {
        switch self {
        case .fetchPosts,
             .fetchOnePost,
             .getDistrict, .getDisstatList, .getGenders, .getDesignations,
             .getSchoolList:
            return nil
        case .register(_ ,let creds):
            let jsonPost = try? JSONEncoder().encode(creds)
            return jsonPost
        case .login(_, let email, let password):
            let login = LoginCredentials(CNIC: email, Password: password)
            let jsonPost = try? JSONEncoder().encode(login)
            return jsonPost
        case .applyForSchool(let schoolID),
             .getStudentAdmissions(let schoolID):
            let creds = ApplySchool(SchoolId: schoolID)
            let jsonPost = try? JSONEncoder().encode(creds)
            return jsonPost
        case .sendPost(_, let post):
            let jsonPost = try? JSONEncoder().encode(post)
            return jsonPost
        }
    }
}

extension URLRequest {
    
    mutating func addValues(for endpoint: Endpoint) {
        switch endpoint {
        case .fetchPosts, .fetchOnePost:
            break
        case .sendPost, 
                .login,
                .register,
                .getDistrict, .getDisstatList, .getGenders, .getDesignations,
                .getSchoolList, .applyForSchool, .getStudentAdmissions:
            self.setValue(
                HTTP.Headers.Value.applicationJson.rawValue,
                forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue
            )
        }
    }
}
