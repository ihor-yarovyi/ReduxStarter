//
//  Rule+SpaceOnly.swift
//  Utils
//
//  Created by Ihor Yarovyi on 8/17/21.
//

import Foundation

public extension Utils.ValidationRules {
    struct SpaceOnly: ValidationRule {
        public init() {}
        
        public func check(_ value: String, for fieldName: String) -> Error? {
            guard value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return nil }
            return Utils.ValidationErrors.SpaceOnly(field: fieldName)
        }
    }
}
