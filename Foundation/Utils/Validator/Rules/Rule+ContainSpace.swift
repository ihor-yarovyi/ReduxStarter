//
//  Rule+ContainSpace.swift
//  Utils
//
//  Created by Ihor Yarovyi on 8/17/21.
//

import Resources

public extension Utils.ValidationRules {
    struct ContainSpace: ValidationRule {
        public init() {}
        
        public func check(_ value: String, for fieldName: String) -> Error? {
            guard value.rangeOfCharacter(from: NSCharacterSet.whitespaces) != nil else { return nil }
            return Utils.ValidationErrors.ContainSpace(field: fieldName)
        }
    }
}
