//
//  RequestProvider.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import Foundation

protocol HasAuthProvider {
    static var auth: AuthProvider { get }
}

typealias RequestProvider = HasAuthProvider
