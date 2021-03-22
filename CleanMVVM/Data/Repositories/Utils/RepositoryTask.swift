//
//  RepositoryTask.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 19/03/2021.
//

import Foundation

class RepositoryTask: Cancellable {
    var isCancelled: Bool = false
    
    func cancel() {
        isCancelled = true
    }
}
