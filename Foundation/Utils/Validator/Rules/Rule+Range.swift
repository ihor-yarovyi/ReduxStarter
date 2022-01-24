//
//  Rule+Range.swift
//  Utils
//
//  Created by Ihor Yarovyi on 8/17/21.
//

import Foundation

public extension Utils.ValidationRules {
    struct Range: ValidationRule {
        public let range: ClosedRange<Int>
        
        public init(_ range: ClosedRange<Int>) {
            self.range = range
        }
        
        public func check(_ value: String, for fieldName: String) -> Error? {
            guard !(value.count >= range.lowerBound && value.count <= range.upperBound) else { return nil }
            return Utils.ValidationErrors.MustBe(field: fieldName, in: range)
        }
    }
}
