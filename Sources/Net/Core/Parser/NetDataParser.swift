//
//  NetDataParser.swift
//  
//
//  Created by Josue Hernandez on 07-10-22.
//

import Foundation

public protocol NetDataParserProtocol {
  func parse<T: Decodable>(data: Data) throws -> T
}

class NetDataParser: NetDataParserProtocol {
  private var jsonDecoder: JSONDecoder

  init(jsonDecoder: JSONDecoder = JSONDecoder()) {
    self.jsonDecoder = jsonDecoder
    self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
  }

  func parse<T: Decodable>(data: Data) throws -> T {
    return try jsonDecoder.decode(T.self, from: data)
  }
}
