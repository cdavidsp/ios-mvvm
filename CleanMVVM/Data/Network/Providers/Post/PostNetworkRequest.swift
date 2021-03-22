//
//  PostNetworkRequest.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 21/03/2021.
//

import Foundation

class PostNetworkRequest: PostNetworkProtocolRequest {
    
    func getAllPosts(completion: @escaping (Result<[PostResponseDTO]?, CustomNetworkError>) -> Void) {
        let postRouter = PostRouter.getAllPosts
        _ = NetworkRequestPerfomer.performRequest(route: postRouter, completion: completion)
    }
    
}
