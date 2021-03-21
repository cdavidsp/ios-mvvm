//
//  CommentsResponseEntity+Mapping.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 17/03/2021.
//

import Foundation
import CoreData

extension CommentResponseEntity {
    func toDTO() -> CommentResponseDTO {
        return .init(postId: Int(postId),
                     id: Int(id),
                     name: name ?? "",
                     email: email ?? "",
                     body: body ?? "")
    }
}


extension CommentResponseDTO {
    func toEntity(in context: NSManagedObjectContext) -> CommentResponseEntity {
        let entity: CommentResponseEntity = .init(context: context)
        entity.id = Int64(id)
        entity.postId = Int64(postId)
        entity.name = name
        entity.email = email
        entity.body = body
        return entity
    }
}

