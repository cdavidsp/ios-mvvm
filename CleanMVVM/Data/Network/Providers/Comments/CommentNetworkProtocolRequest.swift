//
//  CommentNetworkProtocolRequest.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 21/03/2021.
//

import Foundation


/// Protocol for comment request
protocol CommentNetworkProtocolRequest {
    
    /// Get comment data by status and date
    func getAllComments(completion: @escaping (Result<[CommentResponseDTO]?, CustomNetworkError>) -> Void)
}
