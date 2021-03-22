//
//  ViewControllerAssembly.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 22/03/2021.
//

import Foundation
import Swinject

class ViewControllerAssembly: Assembly {
    
    enum ViewControllerIds: String {
        case posts_list_vc
        case post_details_vc
    }
    
    func assemble(container: Container) {
        
        container.register(PostsTableViewController.self) { resolver in
            
            guard let viewModel = resolver.resolve(PostsListViewModel.self) else {
                fatalError("Assembler was unable to resolve PostsListViewModel")
            }
            
            return PostsTableViewController.create(with: viewModel)
           
        }.inObjectScope(.transient)
        
         
        container.register(PostDetailsViewController.self) { resolver in
            
            guard let viewModel = resolver.resolve(PostDetailsViewModel.self) else {
                fatalError("Assembler was unable to resolve PostDetailsViewModel")
            }
            
            return PostDetailsViewController.create(with: viewModel)
           
        }.inObjectScope(.transient)
    }
}
