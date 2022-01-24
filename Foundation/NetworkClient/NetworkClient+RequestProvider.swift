//
//  NetworkClient+RequestProvider.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import Foundation

extension NetworkClient: RequestProvider {
    public static var auth: AuthProvider { API.Provider.Auth.shared }
}
