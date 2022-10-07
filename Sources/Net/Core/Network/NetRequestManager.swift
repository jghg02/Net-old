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
    func initRequest<N: Decodable>(with data: NetRequestProtocol) async throws -> N
}

class NetRequestManager: NetRequestManagerProtocol {
    let netManager: NetManagerProtocol
    
    
    init(netManager: NetManagerProtocol = NetManager()) {
        self.netManager = netManager
    }
    
    func initRequest<N>(with data: NetRequestProtocol) async throws -> N where N : Decodable {
        let data = try await netManager.initRequest(with: data, authToken: "")
        let decoded: N = try parser.parse(data: data)
        return decoded
    }
    
}


extension NetRequestManagerProtocol {
    var parser: NetDataParserProtocol {
        return NetDataParser()
    }
}
