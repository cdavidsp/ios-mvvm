//
//  NetworkSessionManagerMock.swift
//  CleanMVVMTests
//
//  Created by SOSA PEREZ Cesar on 21/03/2021.
//

import Foundation

struct NetworkSessionManagerMock: NetworkSessionManager {
    let response: HTTPURLResponse?
    let data: Data?
    let error: Error?
    
    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) -> NetworkCancellable {
        completion(data, response, error)
        return URLSessionDataTask()
    }
}
