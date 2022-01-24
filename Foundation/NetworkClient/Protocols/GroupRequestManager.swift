//
//  GroupRequestManager.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 01.01.2022.
//

import NetworkLayer
import Combine

public protocol GroupRequestManager: RequestManager, AnyObject {
    func addGroup<Data: Decodable>(
        requests: [NetworkClient.Request<Data>],
        to container: inout [Network.Operator.Request],
        onComplete: @escaping (NetworkClient.Response<[Data]>) -> Void
    ) -> AnyCancellable
}

public extension GroupRequestManager {
    func addGroup<Data: Decodable>(
        requests: [NetworkClient.Request<Data>],
        to container: inout [Network.Operator.Request],
        onComplete: @escaping (NetworkClient.Response<[Data]>) -> Void
    ) -> AnyCancellable {
        var results: [Result<Foundation.Data, Error>] = []
        let isReady = CurrentValueSubject<Bool, Never>(false)
        
        do {
            let networkRequests = try requests.map {
                try NetworkClient.network.createRequest(id: UUID(), from: $0.target, completion: { result in
                    results.append(result)
                    
                    if results.count == requests.count {
                        isReady.send(true)
                    }
                })
            }
            container.append(contentsOf: networkRequests)
        } catch {
            onComplete(.failed(error))
        }
        
        return isReady.eraseToAnyPublisher().sink { value in
            guard value else { return }
            if let error = results.first(where: { $0.error != nil })?.error {
                onComplete(.failed(error))
            } else {
                let handlers = requests.enumerated().map { index, request -> NetworkClient.Response<Data>? in
                    guard let data = results[index].value else { return nil }
                    return request.responseHandler(.success(data))
                }.compactMap { $0 }

                let data = handlers.compactMap { item -> Data? in
                    guard case let .success(data) = item else { return nil }
                    return data
                }
                return onComplete(.success(data))
            }
        }
    }
}
