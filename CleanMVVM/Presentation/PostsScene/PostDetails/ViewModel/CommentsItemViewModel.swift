//
//  CommentsItemViewModel.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 19/03/2021.
//

import Foundation
class CommentsItemViewModel {
    
    let id: Int
    let name: String
    let email: String
    let body: String

    init(comment: Comment) {
        
        self.id = comment.id
        self.name = comment.name ?? ""
        self.email = comment.email ?? ""
        self.body = comment.body ?? ""
    }
}

extension CommentsItemViewModel: Equatable {
    static func == (lhs: CommentsItemViewModel, rhs: CommentsItemViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
