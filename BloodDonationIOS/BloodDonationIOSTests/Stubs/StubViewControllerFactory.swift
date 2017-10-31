//
//  StubViewControllerFactory.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 20/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit
@testable import BloodDonationIOS

class StubViewControllerFactory: ViewControllerFactoryProtocol {

    private(set) var didCallBloodTypeSelector = false
    private(set) var didCallLocationSelector = false
    private(set) var didCallRegister = false
    private(set) var didCallRegisteredUser = false
    private(set) var didCallRegionSelector = false

    func registeredUser(unreigisterAction: Action) -> UIViewController {
        didCallRegisteredUser = true
        return UIViewController()
    }
    
    func bloodTypeSelector(showLocationAction: ShowLocationAction) -> UIViewController {
        didCallBloodTypeSelector = true
        return BloodTypeCollectionViewController()
    }

    func regionSelector(showLocationAction: ShowLocationAction) -> UIViewController {
        didCallRegionSelector = true
        return UIViewController()
    }
    
    func locationSelector(showRegistrationAction: ShowRegistrationAction, countryCode: CountryCode) -> UIViewController {
        didCallLocationSelector = true
        return LocationTableViewController()
    }
    
    func register(bloodType: BloodType, location: LocationModel, showUserRegisteredAction: Action) -> UIViewController {
        didCallRegister = true
        return UIViewController()
    }

}

