//
//  UsersRepository.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 17/03/2021.
//

import Foundation

protocol UsersRepository {
    
    func fetchUsersListAPI( completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable?
    
    func fetchUsersListDB(for id:Int, completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable?
    
    func saveUsersListDB(items: [User], completion: @escaping (Result<[User], Error>) -> Void)
    
    func getLastCall() -> Int
    
    func saveLastCall()
}
