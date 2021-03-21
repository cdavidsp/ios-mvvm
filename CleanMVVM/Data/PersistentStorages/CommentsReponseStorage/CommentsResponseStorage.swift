//
//  PostsResponseStorage.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 17/03/2021.
//

import Foundation

protocol CommentsResponseStorage {
    func getResponse(postId:Int, completion: @escaping (Result<[CommentResponseDTO]?, CoreDataStorageError>) -> Void)
    func save(response: [CommentResponseDTO], completion: @escaping (Result<[CommentResponseDTO]?, CoreDataStorageError>) -> Void)
}
