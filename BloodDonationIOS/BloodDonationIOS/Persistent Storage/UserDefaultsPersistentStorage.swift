//
//  UserPersistentStorageProtocol.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation


protocol PersistentStorageProtocol {
    func setObject(_ value: Any?, forKey key: String)
    func removeObjectForKey(_ key: String)
    func objectForKey(_ key: String) -> Any?
    func allObjects() -> [Any]
}


struct UserDefaultsPersistentStorage: PersistentStorageProtocol {
    
    let userDefaults: UserDefaults
    
    func setObject(_ value: Any?, forKey key: String) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    func removeObjectForKey(_ defaultName: String) {
        userDefaults.removeObject(forKey: defaultName)
        userDefaults.synchronize()
    }
    
    func objectForKey(_ defaultName: String) -> Any? {
        return userDefaults.object(forKey: defaultName)
    }
    
    func allObjects() -> [Any] {
        return userDefaults.dictionaryRepresentation().map{ (key,value) in value }
    }
}
