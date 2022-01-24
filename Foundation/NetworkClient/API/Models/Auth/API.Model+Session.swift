//
//  API.Model+Session.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import Foundation

public extension NetworkClient.API.Model {
    struct Session: Codable {
        public let accessToken: String
        public let refreshToken: String
        public let expiresAt: Int
        
        public init(accessToken: String,
                    refreshToken: String,
                    expiresAt: Int) {
            self.accessToken = accessToken
            self.refreshToken = refreshToken
            self.expiresAt = expiresAt
        }
    }
}
