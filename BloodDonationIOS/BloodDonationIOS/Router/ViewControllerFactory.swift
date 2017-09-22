//
//  ViewControllerFactory.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit


protocol ViewControllerFactoryProtocol {
    func registeredUser(unreigisterAction: Action) -> UIViewController
    func bloodTypeSelector(showLocationAction: ShowLocationAction) -> UIViewController
    func locationSelector(showRegistrationAction: ShowRegistrationAction) -> UIViewController
    func register(bloodType: BloodType, location: LocationModel, showUserRegisteredAction: Action) -> UIViewController
}


struct ViewControllerFactory: ViewControllerFactoryProtocol {
    
    let messagingRegister: MessagingRegisterProtocol
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    let messagingTopicSubscriber = MessagingTopicSubscriber()
    let userStorage: UserPersistentStorageProtocol
    let userRegistered: UserRegistered
    let messagingTopicManager: MessagingTopicManager
    let reporterFactory: ReporterFactory
    
    
    func registeredUser(unreigisterAction: Action) -> UIViewController {
        let areYouSureAlert = AreYouSureAlert()
        let informationAlert = InformationAlert()
        let presenter = UserRegisteredPresenter(userRegistered: userRegistered)
        let viewController = storyboard.instantiateViewController(withIdentifier: "UserRegisteredViewControllerId") as! UserRegisteredViewController
        viewController.configure(presenter: presenter, areYouSureAlert: areYouSureAlert, informationAlert: informationAlert, unreigisterAction: unreigisterAction)
        return viewController
    }
    
    
    func bloodTypeSelector(showLocationAction: ShowLocationAction) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "BloodTypeCollectionViewControllerId") as! BloodTypeCollectionViewController
        let allBloodTypesFetcher = AllBloodTypesFetcher()
        let presenter = BloodTypePresenter(allBloodTypesFetcher: allBloodTypesFetcher)
        let dataSource = CollectionViewDataSource<BloodTypeCollectionViewCell,BloodTypeViewModel>()
        let reporter = reporterFactory.makeSelectBloodReporter()
        viewController.configure(presenter: presenter, dataSource: dataSource, showLocationAction: showLocationAction, reporter: reporter)
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
    
    
    func register(bloodType: BloodType, location: LocationModel, showUserRegisteredAction: Action) -> UIViewController {
        let alert = InformationAlert()
        let registerUser = RegisterUser(userStorage: userStorage, messagingTopicManager: messagingTopicManager, notificationRegister: messagingRegister, bloodType: bloodType, location: location)
        let presenter = RegistrationPresenter(notificationRegister: messagingRegister, messagingSubscriber: messagingTopicSubscriber, registerUser: registerUser)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewControllerId") as! RegistrationViewController
        viewController.configure(presenter: presenter, alert: alert, showUserRegisteredAction: showUserRegisteredAction)
        return viewController
    }
}
