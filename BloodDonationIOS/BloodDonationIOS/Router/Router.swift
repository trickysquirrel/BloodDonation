//
//  Router.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit

class Router {
    
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
        let action = makeDisplayLocationSectionAction()
        let viewController = viewControllerFactory.bloodTypeSelector(showLocationAction: action)
        pushOnController(viewController)
    }
    
    func displayLocationSelection() {
        let viewController = viewControllerFactory.locationSelector()
        pushOnController(viewController)
    }
}

// MARK:- Actions

extension Router {
    
    fileprivate func makeDisplayLocationSectionAction() -> ActionProtocol {
        return Action(performBlock: { [weak self] in
            self?.displayLocationSelection()
        })
    }
}

// MARK:- Navigation Type

extension Router {
    
    fileprivate func pushOnController(_ controller: UIViewController) {
        if navigationController.viewControllers.count == 0 {
            navigationController.viewControllers = [controller]
        }
        else {
            navigationController.pushViewController(controller, animated: true)
        }
    }
}