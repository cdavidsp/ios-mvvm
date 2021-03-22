//
//  CustomError.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 21/03/2021.
//

import Foundation

enum CustomNetworkError: Error {
    case generic_error
    case error_204
    case error_400
    case error_401
    case error_404
    case error_500
    case readError(Error)
    case saveError(Error)
    case deleteError(Error)
}
