//
//  UseCaseAssembly.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 22/03/2021.
//

import Foundation
import Swinject

class UseCaseAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(GetPostsUseCase.self) { resolver in
            
            guard let repository = resolver.resolve(PostsRepository.self) else {
                fatalError("Assembler was unable to resolve PostsRepository")
            }
     
            return DefaultGetPostsUseCase(postsRepository: repository)
        }.inObjectScope(.transient)
        
        container.register(GetUserUseCase.self) { resolver in
            
            guard let repository = resolver.resolve(UsersRepository.self) else {
                fatalError("Assembler was unable to resolve UsersRepository")
            }
     
            return DefaultGetUserUseCase(usersRepository: repository)
        }.inObjectScope(.transient)
        
        container.register(GetCommentsUseCase.self) { resolver in
            
            guard let repository = resolver.resolve(CommentsRepository.self) else {
                fatalError("Assembler was unable to resolve CommentsRepository")
            }
     
            return DefaultGetCommentsUseCase(commentsRepository: repository)
        }.inObjectScope(.transient)
    
    }
    
}

