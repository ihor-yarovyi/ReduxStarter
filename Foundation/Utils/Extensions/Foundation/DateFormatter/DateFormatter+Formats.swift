//
//  DateFormatter+Formats.swift
//  Utils
//
//  Created by Ihor Yarovyi on 11/13/21.
//

import Foundation

public extension DateFormatter {
    static var iso8601: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }
}
