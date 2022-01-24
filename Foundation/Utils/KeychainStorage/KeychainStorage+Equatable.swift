//
//  KeychainStorage+Equatable.swift
//  Utils
//
//  Created by Ihor Yarovyi on 8/25/21.
//

import Foundation

extension Utils.KeychainStorage: Equatable where Value: Equatable {
    public static func == (lhs: Utils.KeychainStorage<Value, ValueEncoder, ValueDecoder>,
                           rhs: Utils.KeychainStorage<Value, ValueEncoder, ValueDecoder>) -> Bool {
        lhs.service == rhs.service && lhs.wrappedValue == rhs.wrappedValue
    }
}
