//
//  Result+Error.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 01.01.2022.
//

import Foundation

extension Result {
    var error: Error? {
        switch self {
        case .success:
            return nil
        case let .failure(error):
            return error
        }
    }
}
