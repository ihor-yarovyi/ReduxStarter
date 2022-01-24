//
//  RequestManager.swift
//  NetworkClient
//
//  Created by Ihor Yarovyi on 9/11/21.
//

import NetworkLayer

public protocol RequestManager {
    func add<Data: Decodable>(
        _ id: UUID,
        request: NetworkClient.Request<Data>,
        to container: inout [Network.Operator.Request],
        onComplete: @escaping (NetworkClient.Response<Data>) -> Void
    )
}

public extension RequestManager {
    func add<Data: Decodable>(
        _ id: UUID,
        request: NetworkClient.Request<Data>,
        to container: inout [Network.Operator.Request],
        onComplete: @escaping (NetworkClient.Response<Data>) -> Void
    ) {
        let networkRequest = try? NetworkClient.network.createRequest(id: id, from: request.target, completion: { result in
            do {
                let data = try result.get()
                onComplete(request.responseHandler(.success(data)))
            } catch {
                onComplete(request.responseHandler(.failure(error)))
            }
        })
        networkRequest.map {
            container.append($0)
        }
    }
}
