
//
//  BloodTypeSelection.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation


struct BloodTypeModel {
    let bloodType: BloodType
    let selected: Bool
}

class BloodTypeSelection {
    
    func fetchBloodTypes() -> [BloodTypeModel] {
        return  [
                BloodTypeModel(bloodType: .oNegative, selected: false),
                BloodTypeModel(bloodType: .oPositive, selected: false),
                BloodTypeModel(bloodType: .aNegative, selected: false),
                BloodTypeModel(bloodType: .aPositive, selected: false),
                BloodTypeModel(bloodType: .bNegative, selected: false),
                BloodTypeModel(bloodType: .bPositive, selected: false),
                BloodTypeModel(bloodType: .abNegative, selected: false),
                BloodTypeModel(bloodType: .abPositive, selected: false)
                ]
    }
}
