//
//  API.Request+Auth.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import NetworkLayer

public extension NetworkClient.API.Request {
    enum Auth: RequestConvertible {
        case signUp(params: [String: Any])
        
        public var path: String {
            switch self {
            case .signUp:
                return "/users"
            }
        }
        
        public var method: Network.Operator.Method {
            switch self {
            case .signUp:
                return .post
            }
        }
        
        public var task: Network.Operator.Task {
            switch self {
            case let .signUp(params):
                return .requestCompositeParameters(bodyParameters: params, bodyEncoding: .json, urlParameters: [:])
            }
        }
        
        public var authorizationStrategy: Network.AuthorizationStrategy? {
            switch self {
            case .signUp:
                return nil
            }
        }
    }
}
