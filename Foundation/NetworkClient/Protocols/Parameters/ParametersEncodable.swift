//
//  ParametersEncodable.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import Foundation

protocol ParametersEncodable {
    associatedtype EncodedValue = Self
    var encodedValue: EncodedValue? { get }
}

extension String: ParametersEncodable {
    var encodedValue: String? { self }
}

extension Bool: ParametersEncodable {
    var encodedValue: Bool? { self }
}

extension Numeric {
    var encodedValue: Self? { self }
}

extension Int: ParametersEncodable {}
extension Int8: ParametersEncodable {}
extension Int16: ParametersEncodable {}
extension Int32: ParametersEncodable {}
extension Int64: ParametersEncodable {}
extension Decimal: ParametersEncodable {}
extension Double: ParametersEncodable {}
extension Float: ParametersEncodable {}

extension NetworkClient.Utils.Parameters: ParametersEncodable {
    var encodedValue: [String: Any]? {
        storage.dictionary
    }
}

extension NetworkClient.Utils.Parameters.Value: ParametersEncodable {
    var encodedValue: Any? {
        storage.dictionary[keyPath: keyPath]
    }
}

extension Optional: ParametersEncodable where Wrapped: ParametersEncodable {
    typealias EncodedValue = Wrapped.EncodedValue
    
    var encodedValue: Wrapped.EncodedValue? {
        self?.encodedValue
    }
}

extension Array: ParametersEncodable where Element: ParametersEncodable {
    var encodedValue: [Element]? {
        self
    }
}

extension Dictionary: ParametersEncodable where Key == String, Value: ParametersEncodable {
    typealias EncodedValue = [Key: Value.EncodedValue]
    
    var encodedValue: [Key: Value.EncodedValue]? {
        reduce(into: [Key: Value.EncodedValue](), { (result, pair) in
            if let value = pair.value.encodedValue {
                result[pair.key] = value
            }
        })
    }
}
