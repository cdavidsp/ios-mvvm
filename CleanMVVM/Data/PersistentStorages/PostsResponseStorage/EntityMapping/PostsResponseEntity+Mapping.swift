//
//  PostsResponseEntity+Mapping.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 17/03/2021.
//

import Foundation
import CoreData

extension PostResponseEntity {
    func toDTO() -> PostResponseDTO {
        return .init(userId: Int(userId),
                     id: Int(id),
                     title: title ?? "",
                     body: body ?? "")
    }
}


extension PostResponseDTO {
    func toEntity(in context: NSManagedObjectContext) -> PostResponseEntity {
        let entity: PostResponseEntity = .init(context: context)
        entity.id = Int64(id)
        entity.userId = Int64(userId)
        entity.title = title
        entity.body = body
        return entity
    }
}

