//
//  ParametersSubscript.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import Foundation

@dynamicMemberLookup
protocol ParametersSubscript {
    func parametersValue(for key: String) -> NetworkClient.Utils.Parameters.Value
}

extension ParametersSubscript {
    /**
     ```
     let parameters: Parameters = ...
     
     parameters.your.key.path <- value // value is some type T: ParametersEncodable
     ```
     */
    subscript(dynamicMember key: String) -> NetworkClient.Utils.Parameters.Value {
        parametersValue(for: key)
    }
    
    subscript<T: ParametersEncodable>(dynamicMember key: String) -> T? {
        self[dynamicMember: key].getValue()
    }
}
