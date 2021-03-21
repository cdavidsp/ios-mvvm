//
//  BaseRepository.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 18/03/2021.
//

import Foundation

class BaseRepository {
    
    func getLasCall(key: LastCallKey) -> Int {
        
            let preferences = UserDefaults.standard
            if preferences.string(forKey: key.rawValue) != nil{
                let value = preferences.integer(forKey: key.rawValue)
                return value
            } else {
                return 0
            }
        }

    func saveLasCall(key: LastCallKey) {
        
        let preferences = UserDefaults.standard
        let currentTime = Int(Date().timeIntervalSince1970)
        
        preferences.set(currentTime, forKey: key.rawValue)
    }
}
enum LastCallKey : String {
    
    case lastCallPosts
    case lastCallComments
    case lastCallUsers
}

