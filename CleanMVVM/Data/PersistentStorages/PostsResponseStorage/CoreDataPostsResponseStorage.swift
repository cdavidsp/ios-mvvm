//
//  CoreDataPostsResponseStorage.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 17/03/2021.
//

import Foundation
import CoreData

final class CoreDataPostsResponseStorage {

    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }

    // MARK: - Private


}

extension CoreDataPostsResponseStorage: PostsResponseStorage {

    func getResponse(completion: @escaping (Result<[PostResponseDTO]?, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let fetchRequest : NSFetchRequest<PostResponseEntity> = PostResponseEntity.fetchRequest()
                
                let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
                
                fetchRequest.sortDescriptors = [sortDescriptor]
                
                let results = try context.fetch(fetchRequest).map { $0.toDTO() }

                completion(.success(results))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }
    
    func save(response responseDto: [PostResponseDTO], completion: @escaping (Result<[PostResponseDTO]?, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                
                let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "PostResponseEntity")
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
                try context.execute(deleteRequest)
                try context.save()
                          
                var postResponseEntities = [PostResponseEntity]()
                for post in responseDto {
                    
                    let postEntity = post.toEntity(in: context)
                    postResponseEntities.append(postEntity)
                }
                
                try context.save()
                
                completion(.success(postResponseEntities.map { $0.toDTO() }))
            } catch {
                
                completion(.failure(CoreDataStorageError.readError(error)))
                
                // TODO: - Log to Crashlytics
                debugPrint("CoreDataPostsResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }

}

