//
//  PersistenceAssembly.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 22/03/2021.
//

import Foundation
import Swinject

class PersistenceAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(PostsResponseStorage.self) { resolver in
            let request = CoreDataPostsResponseStorage()
            return request
        }.inObjectScope(.transient)
        
        
        container.register(CommentsResponseStorage.self) { resolver in
            let request = CoreDataCommentsResponseStorage()
            return request
        }.inObjectScope(.transient)
        
        
        container.register(UsersResponseStorage.self) { resolver in
            let request = CoreDataUsersResponseStorage()
            return request
        }.inObjectScope(.transient)
        
    }
    
}
