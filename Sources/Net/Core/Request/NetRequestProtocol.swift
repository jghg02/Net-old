//
//  NetRequestProtocol.swift
//  
//
//  Created by Josue Hernandez on 07-10-22.
//

import Foundation

public protocol NetRequestProtocol {
    /// This is the base URL
    var host: String { get }
    
    /// This property is the endpoint usually attached at the end of the base URL
    var path: String { get }
    
    /// Specify the type of request 
    var requestType: NetRequestType { get }
    
    /// The all data to send with the request
    var headers: [String: String] { get }
    var params: [String: Any] { get }
    
    /// You will use this dictionary to attache query params in the URL
    var urlParams: [String: String?] { get }
    
    /// Represents if our request needs to add the authorization token
    var addAuthorizationToken: Bool { get }
}

// MARK: - Default values for NetRequestProtocol
extension NetRequestProtocol {
    var addAuthorizationToken: Bool {
      false
    }

    var params: [String: Any] {
      [:]
    }

    var urlParams: [String: String?] {
      [:]
    }

    var headers: [String: String] {
      [:]
    }
    
    func netRequest(authToken: String) throws -> URLRequest {
        var components = URLComponents()
//        components.scheme = "https"
        components.host = host
        components.path = path
        
        if !urlParams.isEmpty {
            components.queryItems = urlParams.map { URLQueryItem(name: $0, value: $1) }
        }
        
        guard let url = components.url else { throw NetworkError.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        
        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        if addAuthorizationToken {
            urlRequest.setValue(authToken, forHTTPHeaderField: "Authorization")
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if !params.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        }
        
        return urlRequest
        
    }
    
}
