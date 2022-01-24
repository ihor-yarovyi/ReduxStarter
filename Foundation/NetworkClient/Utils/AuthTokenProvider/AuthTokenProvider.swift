//
//  AuthTokenProvider.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/28/21.
//

import NetworkLayer

public extension NetworkClient.Utils {
    struct AuthTokenProvider: TokenProvider {
        public var authorization: [String: String]
        
        public init(token: String) {
            authorization = ["Authorization": "Bearer " + token]
        }
    }
}
