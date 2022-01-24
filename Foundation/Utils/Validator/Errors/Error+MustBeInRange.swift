//
//  Error+MustBeInRange.swift
//  Utils
//
//  Created by Ihor Yarovyi on 8/17/21.
//

import Resources

public extension Utils.ValidationErrors {
    struct MustBe: LocalizedError {
        public let fieldName: String
        public let range: ClosedRange<Int>
        
        public init(field fieldName: String, in range: ClosedRange<Int>) {
            self.fieldName = fieldName
            self.range = range
        }
        
        public var errorDescription: String? {
            Strings.Validation.mustBe(fieldName, range.lowerBound, range.upperBound)
        }
    }
}
