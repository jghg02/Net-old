//
//  NetRequestManager.swift
//  
//
//  Created by Josue Hernandez on 07-10-22.
//

import Foundation

public protocol NetRequestManagerProtocol {
    var netManager: NetManagerProtocol { get }
    var parser: NetDataParserProtocol { get }
    func initRequest<T: Decodable>(with data: NetRequestProtocol) async throws -> T
}

public class NetRequestManager: NetRequestManagerProtocol {
    public let netManager: NetManagerProtocol
    
    
    public init(netManager: NetManagerProtocol = NetManager()) {
        self.netManager = netManager
    }
    
    public func initRequest<T>(with data: NetRequestProtocol) async throws -> T where T : Decodable {
        let data = try await netManager.initRequest(with: data, authToken: "")
        let decoded: T = try parser.parse(data: data)
        return decoded
    }
    
}


public extension NetRequestManagerProtocol {
    var parser: NetDataParserProtocol {
        return NetDataParser()
    }
}
