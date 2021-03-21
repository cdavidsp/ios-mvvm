//
//  PostDetailsViewModel.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 19/03/2021. 
//
//

import Foundation

protocol PostDetailsViewModelInput {
    func updateUser()
    func updateComments()
}

protocol PostDetailsViewModelOutput {
    var title: String { get }
    var body: String { get }
    var user: Observable<User?> { get }
    var items: Observable<[CommentsItemViewModel]> { get }
    
}

protocol PostDetailsViewModel: PostDetailsViewModelInput, PostDetailsViewModelOutput { }

final class DefaultPostDetailsViewModel: PostDetailsViewModel {
    
    var items: Observable<[CommentsItemViewModel]> = Observable([])
    
    private let getUserUseCase: GetUserUseCase
    
    private let getCommentsUseCase: GetCommentsUseCase
    // MARK: - OUTPUT
    let id: Int
    let userId: Int
    let title: String
    let user: Observable<User?> = Observable(nil)
    let body: String
    
    private var userLoadTask: Cancellable? { willSet { userLoadTask?.cancel() } }
    private var commentsLoadTask: Cancellable? { willSet { commentsLoadTask?.cancel() } }
    
    
    
    init(post: Post,
         getUserUseCase: GetUserUseCase,
         getCommentsUseCase: GetCommentsUseCase) {
        self.id = post.id
        self.userId = post.userId
        self.title = post.title ?? ""
        self.body = post.body ?? ""
        self.getUserUseCase = getUserUseCase
        self.getCommentsUseCase = getCommentsUseCase
    }
}

// MARK: - INPUT. View event methods
extension DefaultPostDetailsViewModel {
    
    func updateUser() {
        
        let completion: (Result<[User], Error>) -> Void = { result in
            switch result {
            case .success(let data):
                self.user.value = data.first
            case .failure: break
            }
        }
        userLoadTask = getUserUseCase.execute(with: userId, completion: completion)
    }
    func updateComments() {
        
        let completion: (Result<[Comment], Error>) -> Void = { result in
            switch result {
            case .success(let items):
                self.updateItems(items)
            case .failure: break
            }
        }
        commentsLoadTask = getCommentsUseCase.execute(for: id, completion: completion)
    }
    private func updateItems(_ comments: [Comment]) {
       
        items.value = comments.map {
            CommentsItemViewModel(comment: $0)
        }
    }
}
