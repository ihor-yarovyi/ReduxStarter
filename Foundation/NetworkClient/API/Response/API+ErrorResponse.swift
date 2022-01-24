//
//  API+ErrorResponse.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 9/5/21.
//

import Foundation

extension NetworkClient.API {
    struct ErrorResponse<ErrorFormat> {
        let error: ErrorFormat
    }
}

extension NetworkClient.API.ErrorResponse: Decodable where ErrorFormat: Decodable {}
