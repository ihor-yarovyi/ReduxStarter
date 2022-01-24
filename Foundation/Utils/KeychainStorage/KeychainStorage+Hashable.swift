//
//  KeychainStorage+Hashable.swift
//  Utils
//
//  Created by Ihor Yarovyi on 8/25/21.
//

import Foundation

extension Utils.KeychainStorage: Hashable where Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        service.hash(into: &hasher)
        wrappedValue?.hash(into: &hasher)
    }
}
