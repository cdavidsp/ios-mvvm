//
//  RepositoryAssembly.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 22/03/2021.
//

import Foundation
import Swinject

class RepositoryAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(PostsRepository.self) { resolver in
            
            guard let api = resolver.resolve(PostNetworkProtocolRequest.self) else {
                fatalError("Assembler was unable to resolve PostNetworkProtocolRequest")
            }
       
            guard let cache = resolver.resolve(PostsResponseStorage.self) else {
                fatalError("Assembler was unable to resolve PostsResponseStorage")
            }
     
            return DefaultPostsRepository(cache: cache, api: api)
        }.inObjectScope(.transient)
        
        container.register(UsersRepository.self) { resolver in
            
            guard let api = resolver.resolve(UserNetworkProtocolRequest.self) else {
                fatalError("Assembler was unable to resolve UserNetworkProtocolRequest")
            }
       
            guard let cache = resolver.resolve(UsersResponseStorage.self) else {
                fatalError("Assembler was unable to resolve UsersResponseStorage")
            }
     
            return DefaultUsersRepository(cache: cache, api: api)
        }.inObjectScope(.transient)
        
        
        container.register(CommentsRepository.self) { resolver in
            
            guard let api = resolver.resolve(CommentNetworkProtocolRequest.self) else {
                fatalError("Assembler was unable to resolve CommentNetworkProtocolRequest")
            }
       
            guard let cache = resolver.resolve(CommentsResponseStorage.self) else {
                fatalError("Assembler was unable to resolve CommentsResponseStorage")
            }
     
            return DefaultCommentsRepository(cache: cache, api: api)
        }.inObjectScope(.transient)
        
    }
    
}
