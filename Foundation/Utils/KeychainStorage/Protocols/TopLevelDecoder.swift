//
//  TopLevelDecoder.swift
//  Utils
//
//  Created by Ihor Yarovyi on 8/25/21.
//

import Foundation

public protocol TopLevelDecoder {
    associatedtype Input

    func decode<T>(_ type: T.Type, from: Self.Input) throws -> T where T : Decodable
}
