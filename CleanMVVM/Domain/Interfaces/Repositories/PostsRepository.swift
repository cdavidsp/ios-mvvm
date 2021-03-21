//
//  PostsRepository.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 17/03/2021.
//

import Foundation

protocol PostsRepository {
    
    func fetchPostsListAPI( completion: @escaping (Result<[Post], Error>) -> Void) -> Cancellable?
    
    func fetchPostsListDB( completion: @escaping (Result<[Post], Error>) -> Void) -> Cancellable?
    
    func savePostsListDB(items: [Post], completion: @escaping (Result<[Post], Error>) -> Void)
    
    func getLastCall() -> Int
    
    func saveLastCall()
    
}
