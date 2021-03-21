//
//  PostsRepository.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 17/03/2021.
//

import Foundation

protocol CommentsRepository {
    
    func fetchCommentsListAPI( completion: @escaping (Result<[Comment], Error>) -> Void) -> Cancellable?
    
    func fetchCommentsListDB(for postId:Int, completion: @escaping (Result<[Comment], Error>) -> Void) -> Cancellable?
    
    func saveCommentsListDB(items: [Comment], completion: @escaping (Result<[Comment], Error>) -> Void)
    
    func getLastCall() -> Int
    
    func saveLastCall()
    
}
