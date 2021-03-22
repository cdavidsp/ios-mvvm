//
//  PostsListViewModel.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 19/03/2021. 
//

import Foundation

struct PostListViewModelActions {
    
    let showPostDetails: (Post) -> Void
}

protocol PostsListViewModelInput {
    
    func viewWillAppear()
    func didSelect(item: PostsListItemViewModel)
}

protocol PostsListViewModelOutput {
    
    var items: Observable<[PostsListItemViewModel]> { get }
    var postSelected: Observable<Post?> { get }
}

protocol PostsListViewModel: PostsListViewModelInput, PostsListViewModelOutput { }

final class DefaultPostsListViewModel: PostsListViewModel {

    private let getPostsUseCase: GetPostsUseCase
    private let actions: PostListViewModelActions?
    
    private var postsLoadTask: Cancellable? { willSet { postsLoadTask?.cancel() } }

    
    // MARK: - OUTPUT
    let items: Observable<[PostsListItemViewModel]> = Observable([])
    
    let postSelected: Observable<Post?> = Observable(nil)
    
    init(getPostsUseCase: GetPostsUseCase,
         actions: PostListViewModelActions? = nil) {
        self.getPostsUseCase = getPostsUseCase
        self.actions = actions
    }
    
    private func updatePosts() {
        
        let completion: (Result<[Post], Error>) -> Void = { result in
            switch result {
            case .success(let items):
                self.updateItems(items)
            case .failure: break
            }
        }
        postsLoadTask = getPostsUseCase.execute(completion: completion)
    }
    
    
    private func updateItems(_ posts: [Post]) {
       
        items.value = posts.map {
            PostsListItemViewModel(id: $0.id, userId: $0.userId, title: $0.title ?? "", body: $0.body ?? "")
        }
    }
}

// MARK: - INPUT. View event methods
extension DefaultPostsListViewModel {
        
    func viewWillAppear() {
        updatePosts()
    }
    
    func didSelect(item: PostsListItemViewModel) {
        
        postSelected.value = Post(id: item.id,
                                       userId: item.userId,
                                       title: item.title,
                                       body: item.body)
    }
}
