//
//  ViewControllerFactory.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit

struct ViewControllerFactory {
    
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    func bloodTypeSelector(showLocationAction: ShowLocationAction) -> BloodTypeCollectionViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "BloodTypeCollectionViewControllerId") as! BloodTypeCollectionViewController
//        let userDefaultsStorage = UserDefaultsPersistentStorage(userDefaults: UserDefaults.standard)
//        let userStorage = UserPersistentStorage(userDefaultsPersistentStorage: userDefaultsStorage)
        let bloodTypeFetcher = BloodTypeFetcher()
        let presenter = BloodTypePresenter(bloodTypeFetcher: bloodTypeFetcher)
        let dataSource = CollectionViewDataSource<BloodTypeCollectionViewCell,BloodTypeViewModel>()
        viewController.configure(presenter: presenter, dataSource: dataSource, showLocationAction: showLocationAction)
        return viewController
    }
    
    
    func locationSelector(showRegistrationAction: ShowRegistrationAction) -> LocationTableViewController {
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
        let presenter = RegistrationPresenter(bloodType: bloodType, location: location)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewControllerId") as! RegistrationViewController
        viewController.configure(presenter: presenter)
        return viewController
    }
}
