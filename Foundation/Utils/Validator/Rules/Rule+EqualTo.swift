//
//  Rule+EqualTo.swift
//  Utils
//
//  Created by Ihor Yarovyi on 9/11/21.
//

import Foundation

public extension Utils.ValidationRules {
    struct EqualTo: ValidationRule {
        public let otherValue: String
        
        public init(otherValue: String) {
            self.otherValue = otherValue
        }
        
        public func check(_ value: String, for fieldName: String) -> Error? {
            guard otherValue != value else { return nil }
            return Utils.ValidationErrors.NotEqualTo(group: fieldName)
        }
    }
}
