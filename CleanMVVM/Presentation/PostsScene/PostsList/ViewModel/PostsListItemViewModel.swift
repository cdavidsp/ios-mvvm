//
//  PostListItemViewModel.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 19/03/2021. 
//

import Foundation

class PostsListItemViewModel {
    
    let id: Int
    let userId: Int
    let title: String
    let body: String

    init(id: Int, userId: Int, title: String, body: String) {
        
        self.id = id
        self.userId = userId
        self.title = title
        self.body = body
    }
}

extension PostsListItemViewModel: Equatable {
    static func == (lhs: PostsListItemViewModel, rhs: PostsListItemViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
