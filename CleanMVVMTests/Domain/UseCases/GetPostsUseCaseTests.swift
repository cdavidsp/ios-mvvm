//
//  PostsUseCaseTests.swift
//  CleanMVVMTests
//
//  Created by SOSA PEREZ Cesar on 21/03/2021.
//

import XCTest

class GetPostsUseCaseTests: XCTestCase {
    
    static let posts: [Post] = {
        let post1 = Post( id : 1, userId: 1, title: "Title 1", body: "Body 1")
        let post2 = Post( id : 2, userId: 1, title: "Title 2", body: "Body 2")
        return [post1, post2]
    }()
    
    enum PostsRepositorySuccessTestError: Error {
        case failedFetching
    }
    
    class PostsRepositoryMock: PostsRepository {
        
        var postCache: [Post] = []
        
        var lastCall: Int = 0
        
        var resultAPI: Result<[Post], Error>
        
        init(resultAPI: Result<[Post], Error>) {
            
            self.resultAPI = resultAPI
           }
        
        
        func fetchPostsListAPI(completion: @escaping (Result<[Post], Error>) -> Void) -> Cancellable? {
            
            completion(resultAPI)
            return nil
        }
        
        func fetchPostsListDB( completion: @escaping (Result<[Post], Error>) -> Void) -> Cancellable? {
            
            completion(.success(self.postCache))
            return nil
        }
        
        func savePostsListDB(items: [Post], completion: @escaping (Result<[Post], Error>) -> Void) {
            
            self.postCache = items.map({ post in
                 post
            })
            
            completion(.success(self.postCache))
        }
        
        func getLastCall() -> Int {
            
            return self.lastCall
        }
        
        func saveLastCall() {
            
            self.lastCall = Int(Date().timeIntervalSince1970)
        }
        func deleteFirstDB() {
            
            if(self.postCache.count > 0) {
                
                self.postCache.remove(at: 0)
            }
        }
    }
    

    
    func testPostsUseCase_whenSuccessfullyFetchesPostsFromAPI_thenPostsAreSavedInDB() {
        // given
        let expectation = self.expectation(description: "Recent posts saved")
        
        expectation.expectedFulfillmentCount = 2
        
        let resultAPI = Result<[Post], Error>.success(GetPostsUseCaseTests.posts)
        
        let postsRepositoryMock = PostsRepositoryMock(resultAPI: resultAPI)
    
        let useCase = DefaultGetPostsUseCase(postsRepository: postsRepositoryMock)

        // when
        
        _ = useCase.execute() { _ in
            expectation.fulfill()
        }
        // then
        var recents = [Post]()
        _ = postsRepositoryMock.fetchPostsListDB() { result in
            recents = (try? result.get()) ?? []
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(recents.contains(Post( id : 1, userId: 1, title: "Title 1", body: "Body 1")))
    }
    
    func testPostsUseCase_whenUseCaseIsExecutedASecondTime_thenPostsShouldComeFromDB() {
        
        // given
        let expectation = self.expectation(description: "Second time posts saved")
        
        expectation.expectedFulfillmentCount = 2
        
        let resultAPI = Result<[Post], Error>.success(GetPostsUseCaseTests.posts)
        
        let postsRepositoryMock = PostsRepositoryMock(resultAPI: resultAPI)
    
        let useCase = DefaultGetPostsUseCase(postsRepository: postsRepositoryMock)

        // when
        // First time UseCase execution
        _ = useCase.execute() { _ in
            // remove first time in DB (Post with id:1), only for testing
            postsRepositoryMock.deleteFirstDB()
            expectation.fulfill()
        }
        
        
        // Secon time time UseCase execution
        var postsSecondTime = [Post]()
        
        _ = useCase.execute() { result in
            postsSecondTime = (try? result.get()) ?? []
            expectation.fulfill()
        }
        
        // then
       
        waitForExpectations(timeout: 5, handler: nil)
        // Post with id:1 shouldn't be in postsSecondTime result
        XCTAssertTrue(!postsSecondTime.contains(Post( id : 1, userId: 1, title: "Title 1", body: "Body 1")))
    }
}
