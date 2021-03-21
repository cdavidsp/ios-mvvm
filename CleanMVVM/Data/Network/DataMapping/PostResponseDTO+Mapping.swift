//
//  PostResponseDTO+Mapping.swift
//  Data
//
//  Created by SOSA PEREZ Cesar on 19/03/2021.
//  
//

import Foundation

// MARK: - Data Transfer Object

struct PostResponseDTO: Decodable {

    let userId: Int
    let id: Int
    let title: String
    let body: String
}

extension PostResponseDTO {
    func toDomain() -> Post {
        return .init(id: id,
                     userId: userId,
                     title: title,
                     body: body)
    }
}
extension Post {
    func toDTO() -> PostResponseDTO {
        return .init(userId: userId,
                     id: id,
                     title: title ?? "",
                     body: body ?? "")
    }
}

