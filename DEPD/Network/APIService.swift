//
//  APIService.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 26/05/2024.
//

import Foundation

enum APIError: Error {
    case urlSessionError(String)
    case serverError(String = "Invalid API Key")
    case invalidResponse(String = "Invalid response from server.")
    case decodingError(String = "Error parsing server response.")
}

protocol Service {
    func makeRequest<T: Codable>(with request: URLRequest, respModel: T.Type, completion: @escaping (T?, APIError?) -> Void)
}

class APIService: Service {
    
    func makeRequest<T: Codable>(with request: URLRequest,
                                 respModel: T.Type,
                                 completion: @escaping (T?, APIError?) -> Void) {
        
        URLSession.shared.dataTask(with: request) { data, resp, error in
            if let error = error {
                completion(nil, .urlSessionError(error.localizedDescription))
                return
            }
            
            if let resp = resp as? HTTPURLResponse {
                        print("Status Code: \(resp.statusCode)")
                        if resp.statusCode != 200 && resp.statusCode != 201 {
                            completion(nil, .serverError())
                            return
                        }
            }
            
//            if let resp = resp as? HTTPURLResponse, resp.statusCode != 200 || resp.statusCode != 201 {
//                completion(nil, .serverError())
//                return
//            }
            
            guard let data = data else {
                completion(nil, .invalidResponse())
                return
            }

            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                print("PRINT:", String(bytes: data, encoding: .utf8) ?? "")
                completion(result, nil)
                
            } catch let err {
                print(err)
                completion(nil, .decodingError())
                return
            }
             
        }.resume()
    }
    
}
