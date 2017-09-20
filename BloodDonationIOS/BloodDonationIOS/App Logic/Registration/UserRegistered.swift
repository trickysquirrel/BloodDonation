//
//  BloodPersisted.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 20/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation


struct UserRegistered {
    
    let userStorage: UserPersistentStorageProtocol

    func hasUserAlreadyRegistered() -> Bool {
        return userStorage.hasPersistedData()
    }

}
