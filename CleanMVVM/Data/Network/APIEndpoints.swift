//
//  APIEndpoints.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 19/03/2021.
//

import Foundation

struct APIEndpoints {
    
    static func getPosts() -> Endpoint<[PostResponseDTO]> {

        return Endpoint(path: "posts/",
                        method: .get)
    }
    
    static func getComments() -> Endpoint<[CommentResponseDTO]> {

        return Endpoint(path: "comments/",
                        method: .get)
    }
    
    static func getUsers() -> Endpoint<[UserResponseDTO]> {

        return Endpoint(path: "users/",
                        method: .get)
    }
    
}
