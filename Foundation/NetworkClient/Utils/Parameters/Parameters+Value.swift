//
//  Parameters+Value.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import Foundation

extension NetworkClient.Utils.Parameters {
    struct Value: ParametersSubscript {
        
        // MARK: - Private
        
        let storage: Storage
        let keys: [String]
        var keyPath: String {
             keys.joined(separator: ".")
        }
        
        func getValue<T>() -> T? {
            storage.dictionary[keyPath: keyPath] as? T
        }
        
        func setValue<T: ParametersEncodable>(_ value: T, includeNull: Bool = false) {
            if let encodedValue = value.encodedValue {
                storage.dictionary[keyPath: keyPath] = encodedValue
            } else if includeNull {
                storage.dictionary[keyPath: keyPath] = NSNull()
            } else {
                storage.dictionary[keyPath: keyPath] = nil
            }
        }
        
        init(storage: Storage, keys: [String]) {
            self.storage = storage
            self.keys = keys
        }
        
        func parametersValue(for key: String) -> Value {
            NetworkClient.Utils.Parameters.Value(storage: storage, keys: keys + [key])
        }
        
        var value: Any? {
            storage.dictionary[keyPath: keyPath]
        }
    }
}
