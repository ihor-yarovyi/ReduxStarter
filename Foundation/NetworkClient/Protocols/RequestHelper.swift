//
//  RequestHelper.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 8/23/21.
//

import NetworkLayer

protocol RequestHelper {
    var decoder: JSONDecoder { get }
    func prepare<Output: Decodable>(target: RequestConvertible) -> NetworkClient.Request<Output>
    func defaultHandler<Output: Decodable>(_ result: Result<Data, Error>) -> NetworkClient.Response<Output>
    func decode<T: Decodable>(from data: Data) -> NetworkClient.Response<T>
    func handleError<T: Decodable>(_ error: Error) -> NetworkClient.Response<T>
}

extension RequestHelper {
    var decoder: JSONDecoder { JSONDecoder() }
    
    func prepare<Output: Decodable>(target: RequestConvertible) -> NetworkClient.Request<Output> {
        .init(target: target, handler: defaultHandler)
    }
    
    func defaultHandler<Output: Decodable>(_ result: Result<Data, Error>) -> NetworkClient.Response<Output> {
        switch result {
        case let .success(data):
            return decode(from: data)
        case let .failure(error):
            return handleError(error)
        }
    }
    
    func decode<T: Decodable>(from data: Data) -> NetworkClient.Response<T> {
        guard !data.isEmpty else { return .successWithoutResult }
        
        do {
            let value = try decoder.decode(T.self, from: data)
            return .success(value)
        } catch {
            return tryDecodeError(from: data)
        }
    }
    
    func handleError<T: Decodable>(_ error: Error) -> NetworkClient.Response<T> {
        guard let networkError = error as? Network.NetworkError else {
            return .failed(error)
        }
        if networkError.status == .unauthorized {
            return .unauthorized
        } else if networkError.status == .cancelled {
            return .cancelled
        } else if networkError.status == .notConnectedToInternet {
            return .notConnectedToInternet
        } else {
            return .failed(networkError)
        }
    }
    
    // MARK: - Private Method
    private func tryDecodeError<T: Decodable>(from data: Data) -> NetworkClient.Response<T> {
        do {
            let error = try decoder.decode(NetworkClient.API.ErrorResponse<NetworkClient.Utils.DefaultErrorFormat>.self, from: data)
            return .failed(NetworkClient.Utils.ParsedError(error.error))
        } catch {
            return .failed(error)
        }
    }
}
