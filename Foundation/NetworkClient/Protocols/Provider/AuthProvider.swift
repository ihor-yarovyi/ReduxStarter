//
//  AuthProvider.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import Foundation

public protocol AuthProvider {
    func signUp(email: String, username: String, password: String)
    -> NetworkClient.Request<NetworkClient.API.Response<NetworkClient.API.Model.None>>
}
