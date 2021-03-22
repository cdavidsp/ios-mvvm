//
//  UserRouter.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 21/03/2021.
//

import Foundation
import Alamofire

enum UserRouter: APIConfiguration {
   
   
   case getAllUsers
   
   var method: HTTPMethod {
       switch self {
       case .getAllUsers:
           return .get
       }
   }
   
   var path: String {
       switch self {
       case .getAllUsers:
           return "/users/"
       }
   }
   
   var parameters: Parameters? {
       switch self {
       case .getAllUsers:
           return nil
       }
   }
   
   
   func asURLRequest() throws -> URLRequest {
       let url = AppConfigurations.baseURL
       
       var urlRequest = URLRequest(url: URL(string: "\(url)\(path)")!)
       
       // HTTP Method
       urlRequest.httpMethod = method.rawValue
       
       // Common Headers
       urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
       
       // Parameters
       if let parameters = parameters {
           do {
               urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
           } catch {
               throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
           }
       }
       
       return urlRequest
   }
   
   
}
