//
//  LocationModel.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 17/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation


enum CountryCode: String {
    case AU
}


struct LocationModel {
    let name: String
    let area: String
    let countryCode: CountryCode
}
