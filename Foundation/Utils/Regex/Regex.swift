//
//  Regex.swift
//  Utils
//
//  Created by Ihor Yarovyi on 8/17/21.
//

import Foundation

public extension Utils {
    struct Regex {
        public static func match(_ text: String, to regexExpression: String) -> Bool {
            guard let regex = try? NSRegularExpression(pattern: regexExpression, options: []) else { return false }
            let matches = regex.matches(in: text,
                                        options: [],
                                        range: NSRange(location: 0, length: text.count))
            var length = 0
            matches.forEach { res in
                length += res.range.length
            }
            
            return length == text.count
        }
    }
}
