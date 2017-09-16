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
    
    func displayLocationSelection(bloodType: BloodType) {
        let action = makeDisplayRegistrationAction(bloodType: bloodType)
        let viewController = viewControllerFactory.locationSelector(showRegistrationAction: action)
        pushOnController(viewController)
    }
    
    func displayRegistration(bloodType: BloodType, location: LocationModel) {
        let viewController = viewControllerFactory.register(bloodType: bloodType, location: location)
        pushOnController(viewController)
    }
}

// MARK:- Actions

extension Router {
    
    fileprivate func makeDisplayLocationSectionAction() -> ShowLocationAction {
        return ShowLocationAction(performBlock: { [weak self] bloodType in
            self?.displayLocationSelection(bloodType: bloodType)
        })
    }
    
    fileprivate func makeDisplayRegistrationAction(bloodType: BloodType) -> ShowRegistrationAction {
        return ShowRegistrationAction(bloodType: bloodType, performBlock: { [weak self] (bloodType, location) in
            self?.displayRegistration(bloodType: bloodType, location: location)
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
