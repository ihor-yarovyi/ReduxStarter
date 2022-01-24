//
//  DateCoder.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 11/13/21.
//

import Foundation

public extension NetworkClient.Utils {
    class DateCoder: Codable {
        public class var formatter: DateFormatter? { nil }
        public let value: Date

        public init(date: Date) {
            value = date
        }
        
        required public init(from decoder: Decoder) throws {
            let string = try String(from: decoder)
            if let formatter = type(of: self).formatter {
                if let date = formatter.date(from: string) {
                    value = date
                } else {
                    let context = DecodingError.Context(codingPath: decoder.codingPath,
                                                        debugDescription: """
                                                        Invalid date format, expected \(String(describing: formatter.dateFormat)), actual \(string)
                                                        """)
                    throw DecodingError.dataCorrupted(context)
                }
            } else {
                value = try Date(from: decoder)
            }
        }

        public func encode(to encoder: Encoder) throws {
            if let formatter = type(of: self).formatter {
                try formatter.string(from: value).encode(to: encoder)
            } else {
                try value.encode(to: encoder)
            }
        }
    }
}
