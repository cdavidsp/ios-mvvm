//
//  AppConfiguration.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 19/03/2021. 
//

import Foundation

final class AppConfiguration {

    static let timeInSeconds = 300 // time in seconds to wait before to call again to BackEnd
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
    
}
