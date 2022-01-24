//
//  Rule+Required.swift
//  Utils
//
//  Created by Ihor Yarovyi on 8/17/21.
//

import Foundation

public extension Utils.ValidationRules {
    struct Required: ValidationRule {
        public init() {}
        
        public func check(_ value: String, for fieldName: String) -> Error? {
            guard value.isEmpty else { return nil }
            return Utils.ValidationErrors.Required(field: fieldName)
        }
    }
}
