//
//  PostsFlowCoordinator.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 19/03/2021. 
//

import UIKit
import Swinject
/*
protocol PostsFlowCoordinatorDependencies  {
    func makePostsTableViewController(actions: PostListViewModelActions) -> PostsTableViewController
    func makePostDetailsViewController(post: Post) -> PostDetailsViewController
    
}*/

final class PostsFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
   // private let dependencies: PostsFlowCoordinatorDependencies

    private weak var postsTableViewController: PostsTableViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        //self.dependencies = dependencies
    }
    
    func start() {
        
        //let actions = PostListViewModelActions(showPostDetails: showPostDetails)
        
        if let postsViewController = Assembler.sharedAssembler.resolver.resolve(PostsTableViewController.self) {
            self.navigationController?.pushViewController(postsViewController, animated: true)
        }
        
    }
    
    private func showPostDetails(post: Post) {
        /*
        let vc = dependencies.makePostDetailsViewController(post: post)
        navigationController?.pushViewController(vc, animated: true)*/
    }

}
