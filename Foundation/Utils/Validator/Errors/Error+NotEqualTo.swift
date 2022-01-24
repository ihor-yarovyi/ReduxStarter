//
//  Error+NotEqualTo.swift
//  Utils
//
//  Created by Ihor Yarovyi on 9/11/21.
//

import Resources

public extension Utils.ValidationErrors {
    struct NotEqualTo: LocalizedError {
        public let groupName: String
        
        public init(group groupName: String) {
            self.groupName = groupName
        }
        
        public var errorDescription: String? {
            Strings.Validation.notMatch(groupName)
        }
    }
}
