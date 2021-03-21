//
//  UsersUseCaseTests.swift
//  CleanMVVMTests
//
//  Created by SOSA PEREZ Cesar on 21/03/2021.
//

import XCTest

class GetUsersUseCaseTests: XCTestCase {
    
    static let users: [User] = {
        let user1 = User( id : 1, name: "Name 1", username: "Username 1", email: "Email 1")
        let user2 = User( id : 2, name: "Name 2", username: "Username 2", email: "Email 2")
        let user3 = User( id : 3, name: "Name 3", username: "Username 3", email: "Email 3")
        return [user1, user2, user3]
    }()
    
    enum UsersRepositorySuccessTestError: Error {
        case failedFetching
    }
    
    class UsersRepositoryMock: UsersRepository {
 
        
        var userCache: [User] = []
        
        var lastCall: Int = 0
        
        var resultAPI: Result<[User], Error>
        
        init(resultAPI: Result<[User], Error>) {
            
            self.resultAPI = resultAPI
           }
        
        
        func fetchUsersListAPI(completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable? {
            
            completion(resultAPI)
            return nil
        }
        
        func fetchUsersListDB( for id: Int, completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable? {
            
            completion(.success(self.userCache.filter { user in user.id == id }))
            
            return nil
        }
        
        func saveUsersListDB(items: [User], completion: @escaping (Result<[User], Error>) -> Void) {
            
            self.userCache = items.map({ user in
                 user
            })
            
            completion(.success(self.userCache))
        }
        
        func getLastCall() -> Int {
            
            return self.lastCall
        }
        
        func saveLastCall() {
            
            self.lastCall = Int(Date().timeIntervalSince1970)
        }
        func deleteFirstDB() {
            
            if(self.userCache.count > 0) {
                
                self.userCache.remove(at: 0)
            }
        }
    }
    

    
    func testUsersUseCase_whenSuccessfullyFetchesUsersFromAPI_thenUsersAreSavedInDB() {
        // given
        let expectation = self.expectation(description: "Recent users saved")
        
        expectation.expectedFulfillmentCount = 2
        
        let resultAPI = Result<[User], Error>.success(GetUsersUseCaseTests.users)
        
        let usersRepositoryMock = UsersRepositoryMock(resultAPI: resultAPI)
    
        let useCase = DefaultGetUserUseCase(usersRepository: usersRepositoryMock)

        let id = 1
        // when
        
        _ = useCase.execute(with: id) { _ in
            expectation.fulfill()
        }
        // then
        var recents = [User]()
        _ = usersRepositoryMock.fetchUsersListDB(for: id) { result in
            recents = (try? result.get()) ?? []
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(recents.contains(User( id : 1, name: "Name 1", username: "Username 1", email: "Email 1")))
    }
    
    func testUsersUseCase_whenUseCaseIsExecutedASecondTime_thenUsersShouldComeFromDB() {
        
        // given
        let expectation = self.expectation(description: "Second time users saved")
        
        expectation.expectedFulfillmentCount = 2
        
        let resultAPI = Result<[User], Error>.success(GetUsersUseCaseTests.users)
        
        let usersRepositoryMock = UsersRepositoryMock(resultAPI: resultAPI)
    
        let useCase = DefaultGetUserUseCase(usersRepository: usersRepositoryMock)

        let id = 1
        
        // when
        // First time UseCase execution
        _ = useCase.execute(with: id) { _ in
            // remove first time in DB (User with id:1), only for testing
            usersRepositoryMock.deleteFirstDB()
            expectation.fulfill()
        }
        
        
        // Secon time time UseCase execution
        var usersSecondTime = [User]()
        
        _ = useCase.execute(with: id) { result in
            usersSecondTime = (try? result.get()) ?? []
            expectation.fulfill()
        }
        
        // then
       
        waitForExpectations(timeout: 5, handler: nil)
        // User with id:1 shouldn't be in usersSecondTime result
        XCTAssertTrue(!usersSecondTime.contains(User( id : 1, name: "Name 1", username: "Username 1", email: "Email 1")))
    }
}
