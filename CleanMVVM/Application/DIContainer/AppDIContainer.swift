//
//  DIContainer.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 19/03/2021.
//

import Foundation

final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    // MARK: - Network
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!)
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
    
    // MARK: - DIContainers of scenes
    func makePostsSceneDIContainer() -> PostsSceneDIContainer {
        let dependencies = PostsSceneDIContainer.Dependencies(apiDataTransferService: apiDataTransferService)
        return PostsSceneDIContainer(dependencies: dependencies)
    }
}
