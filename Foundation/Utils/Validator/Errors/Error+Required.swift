//
//  Error+Required.swift
//  Utils
//
//  Created by Ihor Yarovyi on 8/17/21.
//

import Resources

public extension Utils.ValidationErrors {
    struct Required: LocalizedError {
        public let fieldName: String
        
        public init(field fieldName: String) {
            self.fieldName = fieldName
        }
        
        public var errorDescription: String? {
            Strings.Validation.required(fieldName)
        }
    }
}
