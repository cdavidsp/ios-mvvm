//
//  AppFlowCoordinator.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 19/03/2021.
//

import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        // In App Flow we can check if user needs to login, if yes we would run login flow
        let PostsSceneDIContainer = appDIContainer.makePostsSceneDIContainer()
        let flow = PostsSceneDIContainer.makePostsFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
