//
//  CommentsUseCaseTests.swift
//  CleanMVVMTests
//
//  Created by SOSA PEREZ Cesar on 21/03/2021.
//

import XCTest

class GetCommentsUseCaseTests: XCTestCase {
    
    static let comments: [Comment] = {
        let comment1 = Comment( id : 1, postId: 1, name: "Name 1", email: "Email 1", body: "Body 1")
        let comment2 = Comment( id : 2, postId: 1, name: "Name 2", email: "Email 2", body: "Body 2")
        let comment3 = Comment( id : 3, postId: 2, name: "Name 3", email: "Email 3", body: "Body 3")
        return [comment1, comment2, comment3]
    }()
    
    enum CommentsRepositorySuccessTestError: Error {
        case failedFetching
    }
    
    class CommentsRepositoryMock: CommentsRepository {
 
        
        var commentCache: [Comment] = []
        
        var lastCall: Int = 0
        
        var resultAPI: Result<[Comment], Error>
        
        init(resultAPI: Result<[Comment], Error>) {
            
            self.resultAPI = resultAPI
           }
        
        
        func fetchCommentsListAPI(completion: @escaping (Result<[Comment], Error>) -> Void) -> Cancellable? {
            
            completion(resultAPI)
            return nil
        }
        
        func fetchCommentsListDB( for postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void) -> Cancellable? {
            
            completion(.success(self.commentCache.filter { comment in comment.postId == postId }))
            
            return nil
        }
        
        func saveCommentsListDB(items: [Comment], completion: @escaping (Result<[Comment], Error>) -> Void) {
            
            self.commentCache = items.map({ comment in
                 comment
            })
            
            completion(.success(self.commentCache))
        }
        
        func getLastCall() -> Int {
            
            return self.lastCall
        }
        
        func saveLastCall() {
            
            self.lastCall = Int(Date().timeIntervalSince1970)
        }
        func deleteFirstDB() {
            
            if(self.commentCache.count > 0) {
                
                self.commentCache.remove(at: 0)
            }
        }
    }
    

    
    func testCommentsUseCase_whenSuccessfullyFetchesCommentsFromAPI_thenCommentsAreSavedInDB() {
        // given
        let expectation = self.expectation(description: "Recent comments saved")
        
        expectation.expectedFulfillmentCount = 2
        
        let resultAPI = Result<[Comment], Error>.success(GetCommentsUseCaseTests.comments)
        
        let commentsRepositoryMock = CommentsRepositoryMock(resultAPI: resultAPI)
    
        let useCase = DefaultGetCommentsUseCase(commentsRepository: commentsRepositoryMock)

        let postId = 1
        // when
        
        _ = useCase.execute(for: postId) { _ in
            expectation.fulfill()
        }
        // then
        var recents = [Comment]()
        _ = commentsRepositoryMock.fetchCommentsListDB(for: postId) { result in
            recents = (try? result.get()) ?? []
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(recents.contains(Comment( id : 1, postId: 1, name: "Name 1", email: "Email 1", body: "Body 1")))
    }
    
    func testCommentsUseCase_whenUseCaseIsExecutedASecondTime_thenCommentsShouldComeFromDB() {
        
        // given
        let expectation = self.expectation(description: "Second time comments saved")
        
        expectation.expectedFulfillmentCount = 2
        
        let resultAPI = Result<[Comment], Error>.success(GetCommentsUseCaseTests.comments)
        
        let commentsRepositoryMock = CommentsRepositoryMock(resultAPI: resultAPI)
    
        let useCase = DefaultGetCommentsUseCase(commentsRepository: commentsRepositoryMock)

        let postId = 1
        
        // when
        // First time UseCase execution
        _ = useCase.execute(for: postId) { _ in
            // remove first time in DB (Comment with id:1), only for testing
            commentsRepositoryMock.deleteFirstDB()
            expectation.fulfill()
        }
        
        
        // Secon time time UseCase execution
        var commentsSecondTime = [Comment]()
        
        _ = useCase.execute(for: postId) { result in
            commentsSecondTime = (try? result.get()) ?? []
            expectation.fulfill()
        }
        
        // then
       
        waitForExpectations(timeout: 5, handler: nil)
        // Comment with id:1 shouldn't be in commentsSecondTime result
        XCTAssertTrue(!commentsSecondTime.contains(Comment( id : 1, postId: 1, name: "Name 1", email: "Email 1", body: "Body 1")))
    }
}
