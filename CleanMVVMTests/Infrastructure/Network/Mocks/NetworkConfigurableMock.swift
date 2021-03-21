//
//  NetworkServiceMocks.swift
//  CleanMVVMTests
//
//  Created by SOSA PEREZ Cesar on 21/03/2021.
//

import Foundation

class NetworkConfigurableMock: NetworkConfigurable {
    var baseURL: URL = URL(string: "https://mock.test.com")!
    var headers: [String: String] = [:]
    var queryParameters: [String: String] = [:]
}
