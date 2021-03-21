//
//  PostsSceneDIContainer.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 19/03/2021. 
//

import UIKit
import SwiftUI

final class PostsSceneDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies

    // MARK: - Persistent Storage
    lazy var usersResponseCache: UsersResponseStorage = CoreDataUsersResponseStorage()
    lazy var commentsResponseCache: CommentsResponseStorage = CoreDataCommentsResponseStorage()
    lazy var postsResponseCache: PostsResponseStorage = CoreDataPostsResponseStorage()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies        
    }
    
    // MARK: - Use Cases
     
    func makeGetPostsUseCase() -> GetPostsUseCase {
        return DefaultGetPostsUseCase(postsRepository: makePostsRepository())
    }

    func makeGetUserUseCase() -> GetUserUseCase {
        return DefaultGetUserUseCase(usersRepository: makeUsersRepository())
    }
    
    func makeGetCommentsUseCase() -> GetCommentsUseCase {
        return DefaultGetCommentsUseCase(commentsRepository: makeCommentsRepository())
    }
    
    
    
    // MARK: - Repositories
    func makePostsRepository() -> PostsRepository {
        return DefaultPostsRepository(dataTransferService: dependencies.apiDataTransferService, cache: postsResponseCache)
    }

    func makeUsersRepository() -> UsersRepository {
        return DefaultUsersRepository(dataTransferService: dependencies.apiDataTransferService, cache: usersResponseCache)
    }

    func makeCommentsRepository() -> CommentsRepository {
        return DefaultCommentsRepository(dataTransferService: dependencies.apiDataTransferService, cache: commentsResponseCache)
    }
    
   
    // MARK: - Post List
    func makePostsTableViewController(actions: PostListViewModelActions) -> PostsTableViewController {
        return PostsTableViewController.create(with: makePostsListViewModel(actions: actions))
    }
    
    func makePostsListViewModel(actions: PostListViewModelActions) -> PostsListViewModel {
        return DefaultPostsListViewModel(getPostsUseCase:  makeGetPostsUseCase(),
                                          actions: actions)
    }
    
    
    // MARK: - Post Details
    func makePostDetailsViewController(post: Post) -> PostDetailsViewController {
        return PostDetailsViewController.create(with: makePostDetailsViewModel(post: post))
    }
    
    func makePostDetailsViewModel(post: Post) -> PostDetailsViewModel {
        return DefaultPostDetailsViewModel(post: post, getUserUseCase: makeGetUserUseCase(), getCommentsUseCase: makeGetCommentsUseCase())
    }
    
    
    // MARK: - Flow Coordinators
    func makePostsFlowCoordinator(navigationController: UINavigationController) -> PostsFlowCoordinator {
        return PostsFlowCoordinator(navigationController: navigationController,
                                           dependencies: self)
    }
}

extension PostsSceneDIContainer: PostsFlowCoordinatorDependencies {}
