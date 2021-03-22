//
//  GetUserUseCase.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 18/03/2021.
//

import Foundation

protocol GetUserUseCase {
    func execute(with id: Int, completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable?
}

final class DefaultGetUserUseCase: GetUserUseCase {

    private let usersRepository: UsersRepository

    init(usersRepository: UsersRepository) {

        self.usersRepository = usersRepository
        
    }

    func execute(with id: Int, completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable? {

        let currentTime = Int(Date().timeIntervalSince1970)
        
        let interval_time = currentTime - usersRepository.getLastCall()
    
        if (interval_time > AppConfigurations.networkSecondsDelta) {
            
            return usersRepository.fetchUsersListAPI(completion: { result in

                switch result {
                case .success(let items):
                    self.usersRepository.saveUsersListDB(items: items) { _ in
                        
                        self.usersRepository.saveLastCall()
                    
                        _ = self.usersRepository.fetchUsersListDB(for: id ) { resultDB in
                        
                            completion(resultDB)
                         }
                     }
                case .failure:
                    
                    completion(result)
                     }
            
            });
        } else {
            
            return self.usersRepository.fetchUsersListDB(for: id) { resultDB in
            
                completion(resultDB)
             }
        }
    }
}
