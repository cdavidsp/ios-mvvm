//
//  User.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 18/03/2021.
//

import Foundation

struct User: Equatable, Identifiable {
    
    typealias Identifier = Int
    let id: Identifier
    let name: String?
    let username: String?
    let email: String?
    
}
