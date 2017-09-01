//
//  Router.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit

struct Router {
    
    let window: UIWindow?
    let viewControllerFactory: ViewControllerFactory
    let navigationController: UINavigationController
    
    init(window: UIWindow?, viewControllerFactory: ViewControllerFactory) {
        self.window = window
        self.viewControllerFactory = viewControllerFactory
        self.navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func displayBloodTypeSeletion() {
        let controller = viewControllerFactory.bloodTypeSelector()
        pushOnController(controller)
    }
}

// MARK:- Navigation Type

extension Router {
    
    private func pushOnController(_ controller: UIViewController) {
        if navigationController.viewControllers.count == 0 {
            navigationController.viewControllers = [controller]
        }
        else {
            navigationController.pushViewController(controller, animated: true)
        }
    }
}
