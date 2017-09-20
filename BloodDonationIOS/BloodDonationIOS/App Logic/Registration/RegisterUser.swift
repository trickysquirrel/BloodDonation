//
//  RegisterUser.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 20/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation


struct RegisterUser {
    
    let userStorage: UserPersistentStorageProtocol
    
    func register(location: LocationModel, bloodType: BloodType) {
        userStorage.persistBloodType(bloodType)
        userStorage.persistLocation(location)
    }
    
}
