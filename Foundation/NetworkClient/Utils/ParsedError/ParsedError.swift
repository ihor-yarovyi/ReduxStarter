//
//  ParsedError.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 9/5/21.
//

import Foundation

extension NetworkClient.Utils {
    struct ParsedError: LocalizedError {
        let error: DefaultErrorFormat
        
        init(_ error: DefaultErrorFormat) {
            self.error = error
        }
        
        var errorDescription: String? {
            error.message
        }
    }
}
