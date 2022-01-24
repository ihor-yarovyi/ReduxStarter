//
//  ValidationRule.swift
//  Utils
//
//  Created by Ihor Yarovyi on 8/17/21.
//

import Foundation

public protocol ValidationRule {
    func check(_ value: String, for fieldName: String) -> Error?
}
