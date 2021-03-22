//
//  AppConfiguration.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 19/03/2021. 
//

import Foundation


enum AppConfigurations {
    /// Get base url value
    static var baseURL: URL {
        var baseEndpoint = ""
        do {
            baseEndpoint = try Configuration.value(for: "ApiBaseURL") as String
        } catch(let error) {
            print("Error :\(error)")
            baseEndpoint = "https://"
        }
        return URL(string: baseEndpoint)!
    }
    
    /// Value indicating the time that must pass between one HTTP call and the next
    static var networkSecondsDelta: Int {
        var seconds = 0
        do {
            seconds = Int(try Configuration.value(for: "ApiSeconds") as String) ?? 0
        } catch(let error) {
            print("Error :\(error)")
            seconds = 0
        }
        return seconds
    }

}


enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

