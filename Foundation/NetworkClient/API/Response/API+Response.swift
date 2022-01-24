//
//  API+Response.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import Foundation

public extension NetworkClient.API {
    struct Response<Value> {
        public let data: Value
        
        public func map<T>(_ transform: (Value) throws -> T) rethrows -> NetworkClient.API.Response<T> {
            let newData = try transform(data)
            return Response<T>(data: newData)
        }
    }
}

extension NetworkClient.API.Response: Decodable where Value: Decodable {}
