//
//  BloodTypeFetcher.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 16/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation


class AllBloodTypesFetcher {
    
    func fetchBloodTypes() -> [BloodType] {        
        let allBloodTypes: [BloodType] = [.oNegative, .oPositive, .aNegative, .aPositive, .bNegative, .bPositive, .abNegative, .abPositive]
        return allBloodTypes
    }
}
