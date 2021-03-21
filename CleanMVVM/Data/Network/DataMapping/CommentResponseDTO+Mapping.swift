//
//  CommentResponseDTO+Mapping.swift
//  Data
//
//  Created by SOSA PEREZ Cesar on 19/03/2021.
//  
//

import Foundation

// MARK: - Data Transfer Object

struct CommentResponseDTO: Decodable {

    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}

extension CommentResponseDTO {
    func toDomain() -> Comment {
        return .init(id: id,
                     postId: postId,
                     name: name,
                     email: email,
                     body: body)
    }
}

extension Comment {
    func toDTO() -> CommentResponseDTO {
        return .init(postId: postId,
                     id: id,
                     name: name ?? "",
                     email: email ?? "",
                     body: body ?? "")
    }
}
