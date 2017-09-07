//
//  UserDefaultsStorage.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation


protocol UserPersistentStorageProtocol {
    func persistBloodType(_ bloodType: BloodType)
    func fetchBloodType() -> BloodType?
}


struct UserPersistentStorage: UserPersistentStorageProtocol {
    
    private let userDefaultsPersistentStorage: PersistentStorageProtocol
    private let storageKey = "UserDefaultsBloodKey"
    
    init(userDefaultsPersistentStorage: PersistentStorageProtocol) {
        self.userDefaultsPersistentStorage = userDefaultsPersistentStorage
    }
    
    func persistBloodType(_ bloodType: BloodType) {
        userDefaultsPersistentStorage.setObject(bloodType.storageValue(), forKey: storageKey)
    }
    
    func fetchBloodType() -> BloodType? {
        let storageValue = userDefaultsPersistentStorage.objectForKey(storageKey) as? String
        return BloodType.bloodTypeFromStorageValue(storageValue)
    }

}
