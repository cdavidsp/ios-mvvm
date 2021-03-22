//
//  GetCommentsUseCase.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 17/03/2021.
//

import Foundation


protocol GetCommentsUseCase {
    func execute(for postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void) -> Cancellable?
}

final class DefaultGetCommentsUseCase: GetCommentsUseCase {

    private let commentsRepository: CommentsRepository

    init(commentsRepository: CommentsRepository) {

        self.commentsRepository = commentsRepository
        
    }

    func execute(for postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void) -> Cancellable? {

       
        let currentTime = Int(Date().timeIntervalSince1970)
        
        let interval_time = currentTime - commentsRepository.getLastCall()
    
        if (interval_time > AppConfigurations.networkSecondsDelta) {
            
            return commentsRepository.fetchCommentsListAPI(completion: { result in

                switch result {
                case .success(let items):
                    self.commentsRepository.saveCommentsListDB(items: items) { _ in
                        
                        self.commentsRepository.saveLastCall()
                    
                        _ = self.commentsRepository.fetchCommentsListDB(for: postId) { resultDB in
                        
                            completion(resultDB)
                         }
                     }
                case .failure:
                    
                        completion(result)
                     }
            
            });
        } else {
            
            return self.commentsRepository.fetchCommentsListDB(for: postId) { resultDB in
            
                completion(resultDB)
             }
        }
    }
}
