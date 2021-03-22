//
//  PostListViewModelTests.swift
//  CleanMVVMTests
//
//  Created by SOSA PEREZ Cesar on 21/03/2021.
//

import Foundation

import XCTest

class PostDetailsViewModelTests: XCTestCase {
    
    private enum PostsUseCaseError: Error {
        case someError
    }
    static let post = Post( id : 1, userId: 1, title: "Title 1", body: "Body 1")
       
    
    static let comments: [Comment] = {
        let comment1 = Comment( id : 1, postId: 1, name: "Name 1", email: " Email 1",body: "Body 1")
        let comment2 = Comment( id : 2, postId: 1, name: "Name 2", email: " Email 2",body: "Body 2")
        return [comment1, comment2]
    }()
    
    static let user = User( id : 1, name: "Name", username: "User name",email: "Email")
 
    class GetCommentsUseCaseMock: GetCommentsUseCase {
        var expectation: XCTestExpectation?
        var error: Error?
        var comments = PostDetailsViewModelTests.comments
        
        func execute(for postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void) -> Cancellable? {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(comments.filter({ (comment) -> Bool in
                    comment.postId == postId
                })))
            }
            expectation?.fulfill()
            return nil
        }
    }
    
    
    class GetUserUseCaseMock: GetUserUseCase {
   
        
        var expectation: XCTestExpectation?
        var error: Error?
        var user = PostDetailsViewModelTests.user
        
        func execute(with id: Int, completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable? {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success([user]))
            }
            expectation?.fulfill()
            return nil
        }
    }

    
    func test_whenPostDetailViewModelRetriveUserData_thenViewModelContainsUserFromUseCase() {
        // given
        let getCommentsUseCaseMock = GetCommentsUseCaseMock()

        let getUserUseCaseMock = GetUserUseCaseMock()
        getUserUseCaseMock.expectation = self.expectation(description: "contains data from use case")
        
        let viewModel = DefaultPostDetailsViewModel(getUserUseCase: getUserUseCaseMock,
                                                    getCommentsUseCase: getCommentsUseCaseMock
                                                   )
        // when
        viewModel.updateUser(userId: PostDetailsViewModelTests.post.userId)
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.user.value, PostDetailsViewModelTests.user)
        
    }
    
    
    
    func test_whenPostDetailViewModelRetriveCommentsData_thenViewModelContainsCommentsFromUseCase() {
        // given
        let getCommentsUseCaseMock = GetCommentsUseCaseMock()
        getCommentsUseCaseMock.expectation = self.expectation(description: "contains data from use case")
        
        let getUserUseCaseMock = GetUserUseCaseMock()
       
        let viewModel = DefaultPostDetailsViewModel(getUserUseCase: getUserUseCaseMock,
                                                    getCommentsUseCase: getCommentsUseCaseMock)
        // when
        viewModel.updateComments(postId: PostDetailsViewModelTests.post.id)
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.items.value.count, PostDetailsViewModelTests.comments.count)
        
    }
}

