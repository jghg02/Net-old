//
//  NetManager.swift
//  
//
//  Created by Josue Hernandez on 07-10-22.
//

import Foundation

public protocol NetManagerProtocol {
    func initRequest(with data: NetRequestProtocol, authToken: String) async throws -> Data
}

public class NetManager: NetManagerProtocol {
    private let urlSession: URLSession
    
    public init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    public func initRequest(with data: NetRequestProtocol, authToken: String = "") async throws -> Data {
        let (data, response) = try await urlSession.data(for: data.netRequest(authToken: authToken))
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else { throw NetworkError.invalidServerResponse }
        return data
    }
    
}
