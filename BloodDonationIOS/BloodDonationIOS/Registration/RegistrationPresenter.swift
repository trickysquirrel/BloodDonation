//
//  RegistrationPresenter.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 17/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

struct RegistrationViewModel {
    let bloodTypeTitle: String
    let locationTitle: String
}


class RegistrationPresenter {
    
    private let bloodType: BloodType
    private let location: LocationModel
    
    init(bloodType: BloodType, location: LocationModel) {
        self.bloodType = bloodType
        self.location = location
    }
    
    func updateView() -> RegistrationViewModel {
        return RegistrationViewModel(bloodTypeTitle:bloodType.displayString(),
                                     locationTitle: makeLocationTitle(location: location))
    }
    
    private func makeLocationTitle(location: LocationModel) -> String {
        return location.countryCode.rawValue + ", " + location.area + ", " + location.name
    }
    
}
