//
//  PostsResponseStorage.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 17/03/2021.
//

import Foundation

protocol UsersResponseStorage {
    func getResponse(id:Int, completion: @escaping (Result<[UserResponseDTO]?, CoreDataStorageError>) -> Void)
    func save(response: [UserResponseDTO],completion: @escaping (Result<[UserResponseDTO]?, CoreDataStorageError>) -> Void)
}
