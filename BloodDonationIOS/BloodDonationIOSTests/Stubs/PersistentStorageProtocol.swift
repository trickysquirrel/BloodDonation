//
//  StubPersistentStorage.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation
@testable import BloodDonationIOS


class StubPersistentStorage: PersistentStorageProtocol {
    
    var dictionaryStorage = [String:Any]()
    
    func setObject(_ value: Any?, forKey key: String) {
        dictionaryStorage[key] = value
    }
    
    func removeObjectForKey(_ key: String) {
        dictionaryStorage.removeValue(forKey: key)
    }
    
    func objectForKey(_ key: String) -> Any? {
        return dictionaryStorage[key]
    }
    
    func allObjects() -> [Any] {
        return dictionaryStorage.map{ (key,value) in value }
    }

}
