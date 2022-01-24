//
//  NetworkClient+NetworkOperator.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 9/11/21.
//

import NetworkLayer

public extension NetworkClient {
    static let network: Network.Operator = Utils.NetworkProvider.shared.network
}
