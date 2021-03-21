//
//  CoreDataCommentsResponseStorage.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 17/03/2021.
//

import Foundation
import CoreData

final class CoreDataCommentsResponseStorage {

    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }

    // MARK: - Private
    
    private func fetchRequest(for postId: Int) -> NSFetchRequest<CommentResponseEntity> {
        let request: NSFetchRequest = CommentResponseEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %d",
                                        #keyPath(CommentResponseEntity.postId), postId)
        
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }

}

extension CoreDataCommentsResponseStorage: CommentsResponseStorage {
    

    func getResponse(postId: Int, completion: @escaping (Result<[CommentResponseDTO]?, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
     
                let request = self.fetchRequest(for: postId)

                let results = try context.fetch(request).map { $0.toDTO() }

                completion(.success(results))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }
    
    func save(response responseDto: [CommentResponseDTO], completion: @escaping (Result<[CommentResponseDTO]?, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                
                let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CommentResponseEntity")
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
                try context.execute(deleteRequest)
                try context.save()
                            
                var commentsResponseEntities = [CommentResponseEntity]()
                for post in responseDto {
                    
                    let postEntity = post.toEntity(in: context)
                    commentsResponseEntities.append(postEntity)
                }
                
                
                try context.save()
                
                completion(.success(commentsResponseEntities.map { $0.toDTO() }))
            } catch {
                
                completion(.failure(CoreDataStorageError.readError(error)))
                // TODO: - Log to Crashlytics
                debugPrint("CoreDataCommentsResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }

}

