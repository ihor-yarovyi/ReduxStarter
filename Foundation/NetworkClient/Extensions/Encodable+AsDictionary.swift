//
//  Encodable+AsDictionary.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import Foundation

struct JSON {
    static let encoder = JSONEncoder()
}

extension Encodable {
    subscript(key: String) -> Any? {
        asDictionary[key]
    }
    
    var asDictionary: [String: Any] {
        (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
    }
}
