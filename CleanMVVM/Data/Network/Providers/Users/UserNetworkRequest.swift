//
//  UserNetworkRequest.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 21/03/2021.
//

import Foundation

class UserNetworkRequest: UserNetworkProtocolRequest {
    
    func getAllUsers(completion: @escaping (Result<[UserResponseDTO]?, CustomNetworkError>) -> Void) {
        let userRouter = UserRouter.getAllUsers
        _ = NetworkRequestPerfomer.performRequest(route: userRouter, completion: completion)
    }
    
}
