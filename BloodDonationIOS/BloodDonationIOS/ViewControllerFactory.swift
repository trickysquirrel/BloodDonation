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
    
    func bloodTypeSelector() -> BloodTypeCollectionViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "BloodTypeCollectionViewControllerId") as! BloodTypeCollectionViewController
        let userDefaultsStorage = UserDefaultsPersistentStorage(userDefaults: UserDefaults.standard)
        let userStorage = UserPersistentStorage(userDefaultsPersistentStorage: userDefaultsStorage)
        let bloodTypeSelection = BloodTypeFetcher(persistentStorage: userStorage)
        let bloodTypeSetter = BloodTypeSetter(persistentStorage: userStorage)
        let presenter = BloodTypePresenter(bloodTypeSelection: bloodTypeSelection, bloodTypeSetter: bloodTypeSetter)
        viewController.configure(presenter: presenter)
        return viewController
    }
}
