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
    
    func bloodTypeSelector(showLocationAction: ActionProtocol) -> BloodTypeCollectionViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "BloodTypeCollectionViewControllerId") as! BloodTypeCollectionViewController
//        let userDefaultsStorage = UserDefaultsPersistentStorage(userDefaults: UserDefaults.standard)
//        let userStorage = UserPersistentStorage(userDefaultsPersistentStorage: userDefaultsStorage)
        let bloodTypeFetcher = BloodTypeFetcher()
        let presenter = BloodTypePresenter(bloodTypeFetcher: bloodTypeFetcher)
        let dataSource = CollectionViewDataSource<BloodTypeCollectionViewCell,BloodTypeViewModel>()
        viewController.configure(presenter: presenter, dataSource: dataSource, showLocationAction: showLocationAction)
        return viewController
    }
    
    
    func locationSelector() -> LocationTableViewController {
        let jsonNetworkRequester = JsonNetworkRequester()
        let locationFetcher = LocationFetcher(jsonRequester: jsonNetworkRequester)
        let presenter = LocationsPresenter(locationFetcher: locationFetcher)
        let dataSource = TableViewDataSource<UITableViewCell, LocationViewModel>()
        let loadingIndicator = LoadingIndicator()
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "LocationTableViewControllerId") as! LocationTableViewController
        viewController.configure(presenter: presenter, dataSource: dataSource, loadingIndicator: loadingIndicator)
        return viewController
    }
}
