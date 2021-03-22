//
//  DefaultUsersRepòsitory.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 17/03/2021.
//

import Foundation

final class DefaultUsersRepository: BaseRepository {

    private let cache: UsersResponseStorage
    private let api: UserNetworkProtocolRequest

    init(cache: UsersResponseStorage, api: UserNetworkProtocolRequest) {
        self.cache = cache
        self.api = api
    }
}

extension DefaultUsersRepository: UsersRepository {
    
    func fetchUsersListAPI( completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable? {
        
        let task = RepositoryTask()
        
        api.getAllUsers() { result in
            
            if case let .success(responseDTO?) = result {
                completion(.success(responseDTO.map { $0.toDomain() }))
            }
        }
        
        return task
    }
    
    
    func fetchUsersListDB(for id: Int, completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable? {
        
        let task = RepositoryTask()
        cache.getResponse(id: id) { result in
            
            if case let .success(responseDTO?) = result {
                completion(.success(responseDTO.map { $0.toDomain() }))
            }
        
        }
        
        return task
    }
    
 
    func saveUsersListDB(items: [User], completion: @escaping (Result<[User], Error>) -> Void) {
        
        
        self.cache.save(response: items.map({ user in user.toDTO() }) ) { result in
     
            if case let .success(responseDTO?) = result {
                completion(.success(responseDTO.map { $0.toDomain() }))
            }
            
        }
        
    }
    
    func getLastCall() -> Int {
        
        let key = LastCallKey.lastCallUsers
        return self.getLasCall(key: key)
    }
    
    func saveLastCall() {
        
        let key = LastCallKey.lastCallUsers
        self.saveLasCall(key: key)
    }
    
}

