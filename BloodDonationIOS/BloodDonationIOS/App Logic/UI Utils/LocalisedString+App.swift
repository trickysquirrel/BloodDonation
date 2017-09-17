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
    case searching = "LOCALKEY_Searching"
    case unknownError = "LOCALKEY_UnknownError"
    case notificationRegistrationError = "LOCALKEY_NotificationRegistrationError"
    
    func localised() -> String {
        return NSLocalizedString(self.rawValue, comment: self.rawValue)
    }
    
    static func localiseError(_ error: Error?) -> String {
        guard (error?.localizedDescription != "unknown") else {
            return Localisations.unknownError.localised()
        }
        guard let error = error else {
            return Localisations.unknownError.localised()
        }
        return error.localizedDescription
    }
}
