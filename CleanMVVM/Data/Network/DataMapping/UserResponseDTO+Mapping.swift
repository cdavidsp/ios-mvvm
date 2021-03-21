//
//  UserResponseDTO+Mapping.swift
//  Data
//
//  Created by SOSA PEREZ Cesar on 19/03/2021.
//  
//

import Foundation

// MARK: - Data Transfer Object


struct UserResponseDTO: Decodable {

    let id: Int
    let username: String
    let name: String
    let email: String
}

extension UserResponseDTO {
    func toDomain() -> User {
        return .init(id: id,
                     name: name,
                     username: username,
                     email: email)
    }
}

extension User {
    func toDTO() -> UserResponseDTO {
        return .init(id: id,
                     username: username ?? "",
                     name: name ?? "",
                     email: email ?? "")
    }
}
