//
//  PostsFlowCoordinator.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 19/03/2021. 
//

import UIKit

protocol PostsFlowCoordinatorDependencies  {
    func makePostsTableViewController(actions: PostListViewModelActions) -> PostsTableViewController
    func makePostDetailsViewController(post: Post) -> PostDetailsViewController
    
}

final class PostsFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: PostsFlowCoordinatorDependencies

    private weak var postsTableViewController: PostsTableViewController?
    
    init(navigationController: UINavigationController,
         dependencies: PostsFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        
        let actions = PostListViewModelActions(showPostDetails: showPostDetails)
        let vc = dependencies.makePostsTableViewController(actions: actions)
        navigationController?.pushViewController(vc, animated: false)
        postsTableViewController = vc
    }
    
    private func showPostDetails(post: Post) {
        
        let vc = dependencies.makePostDetailsViewController(post: post)
        navigationController?.pushViewController(vc, animated: true)
    }

}
