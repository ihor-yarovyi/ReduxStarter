//
//  API.Provider+Auth.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import Foundation

public extension NetworkClient.API.Provider {
    struct Auth: AuthProvider, RequestHelper {
        private init() {}
        
        public static let shared = Auth()
        
        public func signUp(email: String, username: String, password: String)
        -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.None>> {
            let params = NetworkClient.Utils.Parameters {
                $0.email <- email
                $0.username <- username
                $0.password <- password
            }
            return prepare(target: NetworkClient.API.Request.Auth.signUp(params: params.make()))
        }
    }
}
