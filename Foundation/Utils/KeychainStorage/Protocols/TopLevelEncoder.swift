//
//  TopLevelEncoder.swift
//  Utils
//
//  Created by Ihor Yarovyi on 8/25/21.
//

import Foundation

public protocol TopLevelEncoder {
    associatedtype Output

    func encode<T>(_ value: T) throws -> Self.Output where T : Encodable
}
