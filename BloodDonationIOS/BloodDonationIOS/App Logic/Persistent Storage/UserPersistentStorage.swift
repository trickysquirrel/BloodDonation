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
    func persistLocation(_ location: LocationModel)
    func fetchLocation() -> LocationModel?
    func hasPersistedData() -> Bool
}


struct UserPersistentStorage: UserPersistentStorageProtocol {
    
    private let userDefaultsPersistentStorage: PersistentStorageProtocol
    private let storageBloodKey = "UserDefaultsBloodKey"
    private let storageLocationCodeKey = "UserDefaultsLocationCodeKey"
    private let storageLocationAreaKey = "UserDefaultsLocationAreaKey"
    private let storageLocationNameKey = "UserDefaultsLocationNameKey"

    
    init(userDefaultsPersistentStorage: PersistentStorageProtocol) {
        self.userDefaultsPersistentStorage = userDefaultsPersistentStorage
    }
    
    func persistBloodType(_ bloodType: BloodType) {
        userDefaultsPersistentStorage.setObject(bloodType.storageValue(), forKey: storageBloodKey)
    }
    
    func fetchBloodType() -> BloodType? {
        let storageValue = userDefaultsPersistentStorage.objectForKey(storageBloodKey) as? String
        return BloodType.bloodTypeFromStorageValue(storageValue)
    }
    
    func persistLocation(_ location: LocationModel) {
        userDefaultsPersistentStorage.setObject(location.name, forKey: storageLocationNameKey)
        userDefaultsPersistentStorage.setObject(location.area, forKey: storageLocationAreaKey)
        userDefaultsPersistentStorage.setObject(location.countryCode.rawValue, forKey: storageLocationCodeKey)
    }
    
    func fetchLocation() -> LocationModel? {
        guard
        let storedLocationName = userDefaultsPersistentStorage.objectForKey(storageLocationNameKey) as? String,
        let storedLocationArea = userDefaultsPersistentStorage.objectForKey(storageLocationAreaKey) as? String,
        let storedLocationCode = userDefaultsPersistentStorage.objectForKey(storageLocationCodeKey) as? String,
        let locationCountryCode = CountryCode(rawValue: storedLocationCode)
        else {
                return nil
        }
        return LocationModel(name: storedLocationName, area: storedLocationArea, countryCode: locationCountryCode)
    }

    func hasPersistedData() -> Bool {
        return (fetchBloodType() != nil) ? true : false
    }

}
