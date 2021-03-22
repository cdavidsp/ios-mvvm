//
//  UserNetworkProtocolRequest.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 21/03/2021.
//

import Foundation


/// Protocol for user request
protocol UserNetworkProtocolRequest {
    
    /// Get user data by status and date
    func getAllUsers(completion: @escaping (Result<[UserResponseDTO]?, CustomNetworkError>) -> Void)
}
