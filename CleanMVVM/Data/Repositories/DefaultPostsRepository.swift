//
//  DefaultPostsRepòsitory.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 17/03/2021.
//

import Foundation

final class DefaultPostsRepository: BaseRepository {

    private let cache: PostsResponseStorage
    private let api: PostNetworkProtocolRequest

    init(cache: PostsResponseStorage, api: PostNetworkProtocolRequest) {
        self.cache = cache
        self.api = api
    }
}

extension DefaultPostsRepository: PostsRepository {

    
    func fetchPostsListAPI( completion: @escaping (Result<[Post], Error>) -> Void) -> Cancellable? {
        
        let task = RepositoryTask()
        
        api.getAllPosts() { result in
            
            if case let .success(responseDTO?) = result {
                completion(.success(responseDTO.map { $0.toDomain() }))
            }
        }
        
        return task
    }
    
    
    func fetchPostsListDB(completion: @escaping (Result<[Post], Error>) -> Void) -> Cancellable? {
        
        let task = RepositoryTask()
        cache.getResponse() { result in
            
            if case let .success(responseDTO?) = result {
                completion(.success(responseDTO.map { $0.toDomain() }))
            }
        
        }
        
        return task
    }
    
 
    func savePostsListDB(items: [Post], completion: @escaping (Result<[Post], Error>) -> Void) {
        
        
        self.cache.save(response: items.map({ post in post.toDTO() }) ) { result in
     
            if case let .success(responseDTO?) = result {
                completion(.success(responseDTO.map { $0.toDomain() }))
            }
            
        }
        
    }
    
    func getLastCall() -> Int {
        
        let key = LastCallKey.lastCallPosts
        return self.getLasCall(key: key)
    }
    
    func saveLastCall() {
        
        let key = LastCallKey.lastCallPosts
        self.saveLasCall(key: key)
    }
}

