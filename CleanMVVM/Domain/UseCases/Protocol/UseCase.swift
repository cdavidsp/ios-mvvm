//
//  UseCase.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 19/03/2021.
//

import Foundation

public protocol UseCase {
    @discardableResult
    func start() -> Cancellable?
}
