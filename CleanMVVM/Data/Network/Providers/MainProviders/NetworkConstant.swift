//
//  NetworkConstant.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 21/03/2021.
//

import Foundation

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case acceptLanguage = "Accept-Language"
    case subscriptionKey = "Ocp-Apim-Subscription-Key"
}


enum ContentType: String {
    case all = "*/*"
    case json = "application/json"
    case xForm = "application/x-www-form-urlencoded"
}


enum NetworkStatusCode: Int {
    // Undefined error
    case undefined              = 0
    // 2xx Success
    case success                = 200
    case noContent              = 204
    // 4xx Client errors
    case badRequest             = 400
    case unauthorized           = 401
    case forbidden              = 403
    case notFound               = 404
    case methodNotAllowed       = 405
    //5xx Server errors
    case internalServerError    = 500
    case notImplemented         = 501
    case badGateway             = 502
    case serviceUnavailable     = 503
}
