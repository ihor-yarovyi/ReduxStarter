//
//  DefaultErrorFormat.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 9/5/21.
//

import Foundation

extension NetworkClient.Utils {
    struct DefaultErrorFormat: Decodable {
        let message: String
    }
}
