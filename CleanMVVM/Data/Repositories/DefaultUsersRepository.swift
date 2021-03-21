//
//  DefaultUsersRepòsitory.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 17/03/2021.
//

import Foundation

final class DefaultUsersRepository: BaseRepository {

    private let dataTransferService: DataTransferService
    private let cache: UsersResponseStorage

    init(dataTransferService: DataTransferService, cache: UsersResponseStorage) {
        self.dataTransferService = dataTransferService
        self.cache = cache
    }
}

extension DefaultUsersRepository: UsersRepository {
    
    func fetchUsersListAPI( completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable? {
        
        let task = RepositoryTask()
        
        let endpoint = APIEndpoints.getUsers()
        task.networkTask = self.dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.map { $0.toDomain() }))
            case .failure(let error):
                completion(.failure(error))
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

