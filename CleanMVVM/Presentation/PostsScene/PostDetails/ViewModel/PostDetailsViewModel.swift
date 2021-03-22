//
//  PostDetailsViewModel.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 19/03/2021. 
//
//

import Foundation

protocol PostDetailsViewModelInput {
    func updatePost(post: Post)
    func updateUser(userId: Int)
    func updateComments(postId: Int)
}

protocol PostDetailsViewModelOutput {
    
    var post: Observable<Post?> { get }
    var user: Observable<User?> { get }
    var items: Observable<[CommentsItemViewModel]> { get }
    
}

protocol PostDetailsViewModel: PostDetailsViewModelInput, PostDetailsViewModelOutput { }

final class DefaultPostDetailsViewModel: PostDetailsViewModel {
    
    var items: Observable<[CommentsItemViewModel]> = Observable([])
    
    private let getUserUseCase: GetUserUseCase
    
    private let getCommentsUseCase: GetCommentsUseCase
    // MARK: - OUTPUT
    let post: Observable<Post?> = Observable(nil)
    let user: Observable<User?> = Observable(nil)
    
    private var userLoadTask: Cancellable? { willSet { userLoadTask?.cancel() } }
    private var commentsLoadTask: Cancellable? { willSet { commentsLoadTask?.cancel() } }
    
    
    
    init(getUserUseCase: GetUserUseCase,
         getCommentsUseCase: GetCommentsUseCase) {
        self.getUserUseCase = getUserUseCase
        self.getCommentsUseCase = getCommentsUseCase
    }
}

// MARK: - INPUT. View event methods
extension DefaultPostDetailsViewModel {
    
    func updatePost(post: Post) {
        
        self.post.value = post
    }
    
    func updateUser(userId: Int) {
        
        let completion: (Result<[User], Error>) -> Void = { result in
            switch result {
            case .success(let data):
                self.user.value = data.first
            case .failure: break
            }
        }
        userLoadTask = getUserUseCase.execute(with: userId, completion: completion)
    }
    func updateComments(postId: Int) {
        
        let completion: (Result<[Comment], Error>) -> Void = { result in
            switch result {
            case .success(let items):
                self.updateItems(items)
            case .failure: break
            }
        }
        commentsLoadTask = getCommentsUseCase.execute(for: postId, completion: completion)
    }
    private func updateItems(_ comments: [Comment]) {
       
        items.value = comments.map {
            CommentsItemViewModel(comment: $0)
        }
    }
}
