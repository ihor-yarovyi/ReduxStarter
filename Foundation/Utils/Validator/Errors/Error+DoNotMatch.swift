//
//  Error+DoNotMatch.swift
//  Utils
//
//  Created by Ihor Yarovyi on 8/17/21.
//

import Resources

public extension Utils.ValidationErrors {
    struct DoNotMatch: LocalizedError {
        public let fieldName: String
        public let doNotMatchMessage: String
        
        public init(field fieldName: String, doNotMatchMessage: String) {
            self.fieldName = fieldName
            self.doNotMatchMessage = doNotMatchMessage
        }
        
        public var errorDescription: String? {
            doNotMatchMessage
        }
    }
}
