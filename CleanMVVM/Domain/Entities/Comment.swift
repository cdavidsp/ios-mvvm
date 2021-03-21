//
//  Comment.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 18/03/2021.
//

import Foundation

struct Comment: Equatable, Identifiable {
    
    typealias Identifier = Int
    let id: Identifier
    let postId: Int
    let name: String?
    let email: String?
    let body: String?
    
}
