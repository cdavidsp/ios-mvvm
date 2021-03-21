//
//  PostsResponseStorage.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 17/03/2021.
//

import Foundation

protocol PostsResponseStorage {
    func getResponse(completion: @escaping (Result<[PostResponseDTO]?, CoreDataStorageError>) -> Void)
    func save(response: [PostResponseDTO], completion: @escaping (Result<[PostResponseDTO]?, CoreDataStorageError>) -> Void)
}
