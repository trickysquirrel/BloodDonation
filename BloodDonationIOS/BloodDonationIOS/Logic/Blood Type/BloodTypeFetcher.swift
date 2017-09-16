//
//  BloodTypeFetcher.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 16/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation


class BloodTypeFetcher: BloodTypeFetching {
    
    func fetchBloodTypes() -> [BloodTypeModel] {
        
        var response: [BloodTypeModel] = []
        let allBloodTypes: [BloodType] = [.oNegative, .oPositive, .aNegative, .aPositive, .bNegative, .bPositive, .abNegative, .abPositive]
        
        for bloodType in allBloodTypes {
            response.append( BloodTypeModel(bloodType: bloodType, selected: false) )
        }
        return response
    }
}
