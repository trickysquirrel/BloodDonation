//
//  BloodTypeSetter.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 8/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

struct BloodTypeSetter {
    
    let persistentStorage: UserPersistentStorageProtocol
    
    func set(bloodType: BloodType) {
        persistentStorage.persistBloodType(bloodType)
    }
}
