//
//  LocalisedString+App.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 8/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

enum Localisations: String {
    
    // Saved Jobs
    case selectBloodTypeTitle = "LOCALKEY_SelectBloodTypeTitle"
    case minimumLocationCharSearch = "LOCALKEY_MinimumLocationCharSearch"

    
    func localised() -> String {
        return NSLocalizedString(self.rawValue, comment: self.rawValue)
    }
}
