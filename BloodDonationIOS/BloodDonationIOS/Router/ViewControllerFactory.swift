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
    func bloodTypeSelector(showCountryCodeAction: ShowCountryCodeAction) -> UIViewController
    func regionSelector(showLocationAction: ShowLocationAction) -> UIViewController
    func locationSelector(showRegistrationAction: ShowRegistrationAction, countryCode: CountryCode) -> UIViewController
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
    let routerActionsFactory: RouterActionFactoryProtocol
    
    
    func registeredUser(unreigisterAction: Action) -> UIViewController {
        let areYouSureAlert = AreYouSureAlert()
        let informationAlert = InformationAlert()
        let presenter = UserRegisteredPresenter(userRegistered: userRegistered)
        let viewController = storyboard.instantiateViewController(withIdentifier: "UserRegisteredViewControllerId") as! UserRegisteredViewController
        let reporter = reporterFactory.makeUserRegisteredReporter(location: userStorage.fetchLocation(), bloodType: userStorage.fetchBloodType())
        viewController.configure(presenter: presenter, areYouSureAlert: areYouSureAlert, informationAlert: informationAlert, unreigisterAction: unreigisterAction, reporter: reporter)
        return viewController
    }
    
    
    func bloodTypeSelector(showCountryCodeAction: ShowCountryCodeAction) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "BloodTypeCollectionViewControllerId") as! BloodTypeCollectionViewController
        let allBloodTypesFetcher = AllBloodTypesFetcher()
        let presenter = BloodTypePresenter(allBloodTypesFetcher: allBloodTypesFetcher)
        let dataSource = CollectionViewDataSource<BloodTypeCollectionViewCell,BloodTypeViewModel>()
        let reporter = reporterFactory.makeSelectBloodReporter()
        viewController.configure(presenter: presenter, dataSource: dataSource, showCountryCodeAction: showCountryCodeAction, reporter: reporter)
        return viewController
    }


    func regionSelector(showLocationAction: ShowLocationAction) -> UIViewController {
        let presenter = SelectRegionPresenter()
        let viewController = storyboard.instantiateViewController(withIdentifier: "SelectRegionViewControllerID") as! SelectRegionViewController
        viewController.configure(presenter: presenter, actions: showLocationAction)
        return viewController
    }
    
    
    func locationSelector(showRegistrationAction: ShowRegistrationAction, countryCode: CountryCode) -> UIViewController {
        let jsonNetworkRequester = JsonNetworkRequester()
        let locationFetcher = LocationFetcher(jsonRequester: jsonNetworkRequester, countryCode: countryCode)
        let presenter = LocationsPresenter(locationFetcher: locationFetcher)
        let dataSource = TableViewDataSource<UITableViewCell, LocationViewModel>()
        let loadingIndicator = LoadingIndicator()        
        let viewController = storyboard.instantiateViewController(withIdentifier: "LocationTableViewControllerId") as! LocationTableViewController
        let reporter = reporterFactory.makeSelectLocationReporter()
        viewController.configure(presenter: presenter, dataSource: dataSource, loadingIndicator: loadingIndicator, showRegistrationAction: showRegistrationAction, reporter: reporter)
        return viewController
    }
    
    
    func register(bloodType: BloodType, location: LocationModel, showUserRegisteredAction: Action) -> UIViewController {
        let alert = InformationAlert()
        let registerUser = RegisterUser(userStorage: userStorage, messagingTopicManager: messagingTopicManager, notificationRegister: messagingRegister, bloodType: bloodType, location: location)
        let presenter = RegistrationPresenter(notificationRegister: messagingRegister, messagingSubscriber: messagingTopicSubscriber, registerUser: registerUser)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewControllerId") as! RegistrationViewController
        let reporter = reporterFactory.makeRegisterReporterReporter(location: location, bloodType: bloodType)
        viewController.configure(presenter: presenter, alert: alert, showUserRegisteredAction: showUserRegisteredAction, reporter: reporter)
        return viewController
    }
}
