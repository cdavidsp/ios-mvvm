//
//  PostRouter.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 21/03/2021.
//

import Foundation
import Alamofire

enum PostRouter: APIConfiguration {
   
   
   case getAllPosts
   
   var method: HTTPMethod {
       switch self {
       case .getAllPosts:
           return .get
       }
   }
   
   var path: String {
       switch self {
       case .getAllPosts:
           return "/posts/"
       }
   }
   
   var parameters: Parameters? {
       switch self {
       case .getAllPosts:
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
