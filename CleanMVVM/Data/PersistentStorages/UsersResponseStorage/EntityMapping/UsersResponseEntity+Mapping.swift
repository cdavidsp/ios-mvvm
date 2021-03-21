//
//  CommentsResponseEntity+Mapping.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 17/03/2021.
//

import Foundation
import CoreData

extension UserResponseEntity {
    func toDTO() -> UserResponseDTO {
        return .init(id: Int(id),
                     username: username ?? "",
                     name: name ?? "",
                     email: email ?? "")
    }
}


extension UserResponseDTO {
    func toEntity(in context: NSManagedObjectContext) -> UserResponseEntity {
        let entity: UserResponseEntity = .init(context: context)
        entity.id = Int64(id)
        entity.name = name
        entity.email = email
        entity.username = username
        return entity
    }
}

