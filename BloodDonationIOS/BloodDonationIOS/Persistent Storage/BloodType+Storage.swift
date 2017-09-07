//
//  BloodType+Storage.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

extension BloodType {
    
    func storageValue() -> String {
        switch self {
        case .oNegative:
            return "O-"
        case .oPositive:
            return "O+"
        case .aNegative:
            return "A-"
        case .aPositive:
            return "A+"
        case .bNegative:
            return "B-"
        case .bPositive:
            return "B+"
        case .abNegative:
            return "AB-"
        case .abPositive:
            return "AB+"
        }
    }
    
    static func bloodTypeFromStorageValue(_ storageValue: String?) -> BloodType? {
        if storageValue == BloodType.oNegative.storageValue() {
            return BloodType.oNegative
        }
        else if storageValue == BloodType.oNegative.storageValue() {
            return BloodType.oNegative
        }
        else if storageValue == BloodType.oPositive.storageValue() {
            return BloodType.oPositive
        }
        else if storageValue == BloodType.aNegative.storageValue() {
            return BloodType.aNegative
        }
        else if storageValue == BloodType.aPositive.storageValue() {
            return BloodType.aPositive
        }
        else if storageValue == BloodType.bNegative.storageValue() {
            return BloodType.bNegative
        }
        else if storageValue == BloodType.bPositive.storageValue() {
            return BloodType.bPositive
        }
        else if storageValue == BloodType.abNegative.storageValue() {
            return BloodType.abNegative
        }
        else if storageValue == BloodType.abPositive.storageValue() {
            return BloodType.abPositive
        }
        else {
            return nil
        }
    }
}
