//
//  ViewModelAssembly.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 22/03/2021.
//

import Foundation
import Swinject
class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(PostsListViewModel.self) { resolver in
     
            guard let postsUseCase = resolver.resolve(GetPostsUseCase.self) else {
                fatalError("Assembler was unable to resolve GetPostsUseCase")
            }
            
            return DefaultPostsListViewModel(getPostsUseCase:  postsUseCase)
            
        }.inObjectScope(.transient)
        
        
            
        container.register(PostDetailsViewModel.self) { resolver in
     
            guard let userUseCase = resolver.resolve(GetUserUseCase.self) else {
                fatalError("Assembler was unable to resolve GetUserUseCase")
            }
            
            guard let commentsUseCase = resolver.resolve(GetCommentsUseCase.self) else {
                fatalError("Assembler was unable to resolve GetCommentsUseCase")
            }
            
            return DefaultPostDetailsViewModel(
                getUserUseCase: userUseCase,
                getCommentsUseCase: commentsUseCase
            )
            
        }.inObjectScope(.transient)
    
    }
    
}
