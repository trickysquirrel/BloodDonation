//
//  Router.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit

class Router {
    
	private let window: UIWindow?
	private let viewControllerFactory: ViewControllerFactoryProtocol
	private let navigationController: UINavigationController
	private let userRegistered: UserRegistered

	init(window: UIWindow?,
	     navigationController: UINavigationController,
	     viewControllerFactory: ViewControllerFactoryProtocol,
	     userRegistered: UserRegistered) {
		self.window = window
		self.viewControllerFactory = viewControllerFactory
		self.navigationController = navigationController
		self.userRegistered = userRegistered
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}

    func displayFirstViewController() {
        if userRegistered.hasUserAlreadyRegistered() {
            displayUserRegistered()
        }
        else {
            displayBloodTypeSeletion()
        }
    }
}

// MARK: Display view controllers

private extension Router {
    
    func displayUserRegistered() {
        let action = makeUnRegisterAction()
        let viewController = viewControllerFactory.registeredUser(unreigisterAction: action)
        pushOnController(viewController)
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
        let action = makeUserRegisteredAction()
        let viewController = viewControllerFactory.register(bloodType: bloodType, location: location, showUserRegisteredAction: action)
        pushOnController(viewController)
    }
}

// MARK:- Actions

private extension Router {

    func makeUserRegisteredAction() -> Action {
        return Action(performBlock: { [weak self] in
            self?.navigationController.popToRootViewController(animated: false)
            self?.navigationController.viewControllers = []
            self?.displayUserRegistered()
        })
    }

    
    func makeUnRegisterAction() -> Action {
        return Action(performBlock: { [weak self] in
            self?.navigationController.popToRootViewController(animated: false)
            self?.navigationController.viewControllers = []
            self?.displayBloodTypeSeletion()
        })
    }
    
    func makeDisplayLocationSectionAction() -> ShowLocationAction {
        return ShowLocationAction(performBlock: { [weak self] bloodType in
            self?.displayLocationSelection(bloodType: bloodType)
        })
    }
    
    func makeDisplayRegistrationAction(bloodType: BloodType) -> ShowRegistrationAction {
        return ShowRegistrationAction(bloodType: bloodType, performBlock: { [weak self] (bloodType, location) in
            self?.displayRegistration(bloodType: bloodType, location: location)
        })
    }
}

// MARK:- Navigation Type

 private extension Router {
    
    func pushOnController(_ controller: UIViewController) {
        if navigationController.viewControllers.count == 0 {
            navigationController.viewControllers = [controller]
        }
        else {
            navigationController.pushViewController(controller, animated: true)
        }
    }
}
