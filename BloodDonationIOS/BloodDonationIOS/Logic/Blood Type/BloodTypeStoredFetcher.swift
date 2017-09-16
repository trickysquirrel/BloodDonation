//
//  BloodTypeSelection.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

class BloodTypeStoredFetcher: BloodTypeFetching {
    
    let persistentStorage: UserPersistentStorageProtocol
    
    init(persistentStorage: UserPersistentStorageProtocol) {
        self.persistentStorage = persistentStorage
    }
    
    func fetchBloodTypes() -> [BloodTypeModel] {
        
        var response: [BloodTypeModel] = []
        let usersBloodType = persistentStorage.fetchBloodType()
        let allBloodTypes: [BloodType] = [.oNegative, .oPositive, .aNegative, .aPositive, .bNegative, .bPositive, .abNegative, .abPositive]
        
        for bloodType in allBloodTypes {
            let selected = (bloodType == usersBloodType)
            response.append( BloodTypeModel(bloodType: bloodType, selected: selected) )
        }
        return response
    }
}
