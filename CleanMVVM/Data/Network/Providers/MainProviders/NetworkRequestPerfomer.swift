//
//  NetworkRequestPerfomer.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 21/03/2021.
//

import Foundation
import Alamofire

class NetworkRequestPerfomer {
    
    /// A generic network request performer for execute all request for router that extends APIConfiguration
    /// - Parameters:
    ///   - route: Router object
    ///   - success: success operation
    ///   - failure: fail operation
    /// - Returns: Current network operation request
    public static func performRequest<T:Decodable>(route: APIConfiguration, completion: @escaping (Result<T, CustomNetworkError>) -> Void ) -> DataRequest {
        return AF.request(route)
            .responseJSON { response in
                do {
                    if response.error != nil {
                        let localizedDesctiptionError: String = response.error?.localizedDescription ?? ""
                        if response.data != nil {
                            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                                print("Data response: \(utf8Text)")
                            }
                        } else {
                            print("Error: \(localizedDesctiptionError)")
                        }
                        if (response.response?.statusCode) != nil {
                            
                            completion(.failure(CustomNetworkError.generic_error))
                        }
                        
                    } else {
                        if let responseData = response.data {
                            
                            debugPrint("Data response: \(responseData)")
                       
                            let statusCode = response.response?.statusCode
                               
                                
                                if let statusCode = statusCode {
                                    
                                    switch statusCode {
                                        
                                    case NetworkStatusCode.success.rawValue:
                                        // 200 network status code reached
                                        
                                        completion(.success(try JSONDecoder().decode(T.self, from: responseData)))
                                        
                                    case NetworkStatusCode.noContent.rawValue:
                                        // Manage 204 code.
                                        
                                        debugPrint("Data response: \(NetworkStatusCode.noContent.rawValue)")
                                        completion(.failure(CustomNetworkError.error_204))
                                    case NetworkStatusCode.unauthorized.rawValue:
                                        // Manage 401 erorr code.
                                        
                                        debugPrint("Data response: \(NetworkStatusCode.unauthorized.rawValue)")
                                        
                                         completion(.failure(CustomNetworkError.error_401))
                                    case NetworkStatusCode.badRequest.rawValue:
                                        // Manage 400 erorr code.
                                        
                                         completion(.failure(CustomNetworkError.error_400))
                                    case NetworkStatusCode.notFound.rawValue:
                                        // Manage 404 error.
                                        
                                         completion(.failure(CustomNetworkError.error_404))
                                    case NetworkStatusCode.forbidden.rawValue:
                                        
                                         completion(.failure(CustomNetworkError.generic_error))
                                    default:
                                        // Manage unknow erorr code.
                                        completion(.failure(CustomNetworkError.generic_error))
                                    }
                                }
                                else {
                                    
                                     completion(.failure(CustomNetworkError.generic_error))
                                }
                         
                            
                            
                        } else {
                            
                             completion(.failure(CustomNetworkError.generic_error))
                        }
                    }
                } catch {
                  
                     completion(.failure(CustomNetworkError.readError(error)))
                }
        }
    }

    
}
