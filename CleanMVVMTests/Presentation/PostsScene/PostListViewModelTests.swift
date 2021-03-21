//
//  PostListViewModelTests.swift
//  CleanMVVMTests
//
//  Created by SOSA PEREZ Cesar on 21/03/2021.
//

import Foundation

import XCTest

class PostListViewModelTests: XCTestCase {
    
    private enum PostsUseCaseError: Error {
        case someError
    }
    
    static let posts: [Post] = {
        let post1 = Post( id : 1, userId: 1, title: "Title 1", body: "Body 1")
        let post2 = Post( id : 2, userId: 1, title: "Title 2", body: "Body 2")
        return [post1, post2]
    }()
    
    class GetPostsUseCaseMock: GetPostsUseCase {
        var expectation: XCTestExpectation?
        var error: Error?
        var posts = PostListViewModelTests.posts
        
        func execute(completion: @escaping (Result<[Post], Error>) -> Void) -> Cancellable? {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(posts))
            }
            expectation?.fulfill()
            return nil
        }
    }
    
    func test_whenPostListViewModelRetrivePostData_thenViewModelContainsPostsFromUseCase() {
        // given
        let getPostsUseCaseMock = GetPostsUseCaseMock()
        getPostsUseCaseMock.expectation = self.expectation(description: "contains data from use case")
        
        let viewModel = DefaultPostsListViewModel(getPostsUseCase: getPostsUseCaseMock)
        // when
        viewModel.viewWillAppear()
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.items.value.count, 2)
        
    }
}

