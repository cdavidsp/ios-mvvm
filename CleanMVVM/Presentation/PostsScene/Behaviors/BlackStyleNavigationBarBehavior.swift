//
//  BlackStyleNavigationBarBehavior.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 19/03/2021. 
//

import UIKit

struct BlackStyleNavigationBarBehavior: ViewControllerLifecycleBehavior {

    func viewDidLoad(viewController: UIViewController) {

        viewController.navigationController?.navigationBar.barStyle = .black
    }
}
