//
//  Parameters.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import Foundation

/**
 `Parameters` allows to create arbitary dictionaries with ease.
 ```
 let parameters = Parameters {
     $0.name.first <- "John"
     $0.name.last <- "Dou"
 }
 
 let dictionary = parameters.make() // ["name": ["first": "John", "last": "Dou"]]
 ```
 */
extension NetworkClient.Utils {
    struct Parameters: ParametersSubscript {
        // MARK: - Private
        let storage: NetworkClient.Utils.Parameters.Storage
        
        init(storage: Storage) {
            self.storage = storage
        }
        
        // MARK: - Public
        init(builder: (inout Parameters) -> Void = { _ in }) {
            self.init(storage: Storage())
            builder(&self)
        }
        
        func parametersValue(for key: String) -> Parameters.Value {
            Parameters.Value(storage: storage, keys: [key])
        }
        
        func make() -> [String: Any] {
            storage.dictionary
        }
    }
}
