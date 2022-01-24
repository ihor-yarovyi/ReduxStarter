//
//  NetworkClient+Response.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import Foundation

public extension NetworkClient {
    enum Response<Result: Decodable> {
        case success(Result)
        case successWithoutResult
        case cancelled
        case unauthorized
        case notConnectedToInternet
        case failed(Error)
    }
}
