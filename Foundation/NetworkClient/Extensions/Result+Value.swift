//
//  Result+Value.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 01.01.2022.
//

import Foundation

extension Result {
    var value: Success? {
        switch self {
        case let .success(data):
            return data
        case .failure:
            return nil
        }
    }
}
