//
//  PostNetworkProtocolRequest.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 21/03/2021.
//

import Foundation


/// Protocol for post request
protocol PostNetworkProtocolRequest {
    
    /// Get post data by status and date
    func getAllPosts(completion: @escaping (Result<[PostResponseDTO]?, CustomNetworkError>) -> Void)
}
