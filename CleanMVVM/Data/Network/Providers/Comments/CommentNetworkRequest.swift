//
//  CommentNetworkRequest.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 21/03/2021.
//

import Foundation

class CommentNetworkRequest: CommentNetworkProtocolRequest {
    
    func getAllComments(completion: @escaping (Result<[CommentResponseDTO]?, CustomNetworkError>) -> Void) {
        let commentRouter = CommentRouter.getAllComments
        _ = NetworkRequestPerfomer.performRequest(route: commentRouter, completion: completion)
    }
    
}
