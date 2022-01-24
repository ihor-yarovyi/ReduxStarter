//
//  NetworkProvider.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 9/11/21.
//

import EnvConfig
import NetworkLayer

extension NetworkClient.Utils {
    struct NetworkProvider {
        
        static let shared = NetworkProvider()
        let network: Network.Operator
        
        private init() {
            network = NetworkLayer.Network.Operator(baseURL: EnvConfig.Environment.current.baseURL)
        }
    }
}
