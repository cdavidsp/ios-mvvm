//
//  Post.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 17/03/2021.
//

import Foundation

struct Post: Equatable, Identifiable {
    
    typealias Identifier = Int
    let id: Identifier
    let userId: Int
    let title: String?
    let body: String?
    
}
