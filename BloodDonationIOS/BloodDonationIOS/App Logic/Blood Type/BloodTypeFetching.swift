//
//  BloodTypeFetching.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 16/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

protocol BloodTypeFetching {
    func fetchBloodTypes() -> [BloodType]
}
