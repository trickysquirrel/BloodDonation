//
//  ViewControllerFactory.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit


protocol ViewControllerFactoryProtocol {
    func registeredUser() -> UIViewController
    func bloodTypeSelector(showLocationAction: ShowLocationAction) -> UIViewController
    func locationSelector(showRegistrationAction: ShowRegistrationAction) -> UIViewController
    func register(bloodType: BloodType, location: LocationModel) -> UIViewController
}


struct ViewControllerFactory: ViewControllerFactoryProtocol {
    
    let notificationRegister: MessagingRegister
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    let userStorage: UserPersistentStorageProtocol
    
    
    func registeredUser() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "UserRegisteredViewControllerId") as! UserRegisteredViewController
        return viewController
    }
    
    
    func bloodTypeSelector(showLocationAction: ShowLocationAction) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "BloodTypeCollectionViewControllerId") as! BloodTypeCollectionViewController
        let bloodTypeFetcher = BloodTypeFetcher()
        let presenter = BloodTypePresenter(bloodTypeFetcher: bloodTypeFetcher)
        let dataSource = CollectionViewDataSource<BloodTypeCollectionViewCell,BloodTypeViewModel>()
        viewController.configure(presenter: presenter, dataSource: dataSource, showLocationAction: showLocationAction)
        return viewController
    }
    
    
    func locationSelector(showRegistrationAction: ShowRegistrationAction) -> UIViewController {
        let jsonNetworkRequester = JsonNetworkRequester()
        let locationFetcher = LocationFetcher(jsonRequester: jsonNetworkRequester)
        let presenter = LocationsPresenter(locationFetcher: locationFetcher)
        let dataSource = TableViewDataSource<UITableViewCell, LocationViewModel>()
        let loadingIndicator = LoadingIndicator()        
        let viewController = storyboard.instantiateViewController(withIdentifier: "LocationTableViewControllerId") as! LocationTableViewController
        viewController.configure(presenter: presenter, dataSource: dataSource, loadingIndicator: loadingIndicator, showRegistrationAction: showRegistrationAction)
        return viewController
    }
    
    
    func register(bloodType: BloodType, location: LocationModel) -> UIViewController {
        let alert = Alert()
        let registerUser = RegisterUser(userStorage: userStorage)
        let messagingSubscriber = MessagingSubscriber()
        let presenter = RegistrationPresenter(bloodType: bloodType, location: location, notificationRegister: notificationRegister, messagingSubscriber: messagingSubscriber, registerUser: registerUser)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewControllerId") as! RegistrationViewController
        viewController.configure(presenter: presenter, alert: alert)
        return viewController
    }
}
