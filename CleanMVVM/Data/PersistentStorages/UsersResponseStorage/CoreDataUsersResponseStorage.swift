//
//  CoreDataUsersResponseStorage.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 17/03/2021.
//

import Foundation
import CoreData

final class CoreDataUsersResponseStorage {

    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }

    // MARK: - Private
   

    
}

extension CoreDataUsersResponseStorage: UsersResponseStorage {

    
    
    func getResponse(id: Int, completion: @escaping (Result<[UserResponseDTO]?, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                
                let fetchRequest : NSFetchRequest<UserResponseEntity> = UserResponseEntity.fetchRequest()
           
                let predicate = NSPredicate(format: "id = %d", id)
                
                fetchRequest.predicate = predicate
                
                let results = try context.fetch(fetchRequest).map { $0.toDTO() }
                
                completion(.success(results))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }
    
    func save(response responseDto: [UserResponseDTO], completion: @escaping (Result<[UserResponseDTO]?, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                
                let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UserResponseEntity")
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
                try context.execute(deleteRequest)
                try context.save()
                            
                var usersResponseEntities = [UserResponseEntity]()
                for post in responseDto {
                    
                    let postEntity = post.toEntity(in: context)
                    usersResponseEntities.append(postEntity)
                }
                
                
                try context.save()
                
                completion(.success(usersResponseEntities.map { $0.toDTO() }))
            } catch {
                
                completion(.failure(CoreDataStorageError.readError(error)))
                // TODO: - Log to Crashlytics
                debugPrint("CoreDataUsersResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }

}

