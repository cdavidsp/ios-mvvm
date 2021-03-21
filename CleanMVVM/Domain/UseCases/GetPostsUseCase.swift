//
//  GetPostsUseCase.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 17/03/2021.
//

import Foundation


protocol GetPostsUseCase {
    func execute(completion: @escaping (Result<[Post], Error>) -> Void) -> Cancellable?
}

final class DefaultGetPostsUseCase: GetPostsUseCase {

    private let postsRepository: PostsRepository

    init(postsRepository: PostsRepository) {

        self.postsRepository = postsRepository
        
    }

    func execute(completion: @escaping (Result<[Post], Error>) -> Void) -> Cancellable? {

        
        let currentTime = Int(Date().timeIntervalSince1970)
        
        let interval_time = currentTime - postsRepository.getLastCall()
    
        if (interval_time > AppConfiguration.timeInSeconds) {
            
            return postsRepository.fetchPostsListAPI(completion: { result in

                switch result {
                case .success(let items):
                    self.postsRepository.savePostsListDB(items: items) { _ in
                        
                        self.postsRepository.saveLastCall()
                        
                        _ = self.postsRepository.fetchPostsListDB() { resultDB in
                        
                            completion(resultDB)
                         }
                     }
                case .failure:
                    
                        completion(result)
                     }
            
            });
        } else {
            
            return self.postsRepository.fetchPostsListDB() { resultDB in
            
                completion(resultDB)
             }
        }
    
    }
}
