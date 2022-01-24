//
//  Operator.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import Foundation

precedencegroup ParametersPrecedence {
    lowerThan: AdditionPrecedence
}

infix operator <-: ParametersPrecedence

extension NetworkClient.Utils.Parameters.Value {
    static func <- <T: ParametersEncodable>(lhs: NetworkClient.Utils.Parameters.Value, rhs: T) {
        lhs.setValue(rhs)
    }
}
