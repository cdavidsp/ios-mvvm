//
//  NetworkAssembly.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 22/03/2021.
//

import Foundation

import Swinject

class NetworkAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(PostNetworkProtocolRequest.self) { resolver in
            let request = PostNetworkRequest()
            return request
        }.inObjectScope(.transient)
        
        container.register(UserNetworkProtocolRequest.self) { resolver in
            let request = UserNetworkRequest()
            return request
        }.inObjectScope(.transient)
        
        container.register(CommentNetworkProtocolRequest.self) { resolver in
            let request = CommentNetworkRequest()
            return request
        }.inObjectScope(.transient)
        
    }
    
}
