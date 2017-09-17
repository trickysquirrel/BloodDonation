//
//  BloodType+Presentable.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

extension BloodType {
    func displayString() -> String {
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
}
