//
//  ISO8601DateCoder.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 11/13/21.
//

import Utils

public extension NetworkClient.Utils {
    final class ISO8601DateCoder: DateCoder {
        public override class var formatter: DateFormatter? {
            .iso8601
        }
    }
}
