//
//  DefaultCommentsRepòsitory.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 17/03/2021.
//

import Foundation

final class DefaultCommentsRepository: BaseRepository {

    private let dataTransferService: DataTransferService
    private let cache: CommentsResponseStorage

    init(dataTransferService: DataTransferService, cache: CommentsResponseStorage) {
        self.dataTransferService = dataTransferService
        self.cache = cache
    }
}

extension DefaultCommentsRepository: CommentsRepository {
    
    func fetchCommentsListAPI( completion: @escaping (Result<[Comment], Error>) -> Void) -> Cancellable? {
        
        let task = RepositoryTask()
        
        let endpoint = APIEndpoints.getComments()
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
    
    
    func fetchCommentsListDB(for postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void) -> Cancellable? {
        
        let task = RepositoryTask()
        cache.getResponse(postId: postId) { result in
            
            if case let .success(responseDTO?) = result {
                completion(.success(responseDTO.map { $0.toDomain() }))
            }
        
        }
        
        return task
    }
    
 
    func saveCommentsListDB(items: [Comment], completion: @escaping (Result<[Comment], Error>) -> Void) {
        
        
        self.cache.save(response: items.map({ comment in comment.toDTO() }) ) { result in
     
            if case let .success(responseDTO?) = result {
                completion(.success(responseDTO.map { $0.toDomain() }))
            }
            
        }
        
    }
    
    func getLastCall() -> Int {
        
        let key = LastCallKey.lastCallComments
        return self.getLasCall(key: key)
    }
    
    func saveLastCall() {
        
        let key = LastCallKey.lastCallComments
        self.saveLasCall(key: key)
    }
}

