//
//  NetworkClient+Request.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import NetworkLayer

public extension NetworkClient {
    struct Request<Output: Decodable> {
        public let target: RequestConvertible
        public let responseHandler: (Result<Data, Error>) -> Response<Output>
        
        public init(target: RequestConvertible,
                    handler responseHandler: @escaping (Result<Data, Error>) -> Response<Output>) {
            self.target = target
            self.responseHandler = responseHandler
        }
    }
}
