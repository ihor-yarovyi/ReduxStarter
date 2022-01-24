//
//  Validatable.swift
//  Utils
//
//  Created by Ihor Yarovyi on 8/17/21.
//

import Foundation

public protocol Validatable {
    static var name: String { get }
    static var rules: [ValidationRule] { get }
    static func validate(_ value: String) -> Error?
}

public extension Validatable {
    static var name: String {
        String(describing: Self.self)
    }
    
    static func validate(_ value: String) -> Error? {
        rules.map { $0.check(value, for: name) }.compactMap { $0 }.first
    }
}
