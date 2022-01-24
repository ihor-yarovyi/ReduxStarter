//
//  Rule+Match.swift
//  Utils
//
//  Created by Ihor Yarovyi on 8/17/21.
//

import Foundation

public extension Utils.ValidationRules {
    struct Match: ValidationRule {
        public let regex: String
        public let doNotMatchMessage: String
        
        public init(regex: String, message doNotMatchMessage: String) {
            self.regex = regex
            self.doNotMatchMessage = doNotMatchMessage
        }
        
        public func check(_ value: String, for fieldName: String) -> Error? {
            guard !Utils.Regex.match(value, to: regex) else { return nil }
            return Utils.ValidationErrors.DoNotMatch(field: fieldName, doNotMatchMessage: doNotMatchMessage)
        }
    }
}
