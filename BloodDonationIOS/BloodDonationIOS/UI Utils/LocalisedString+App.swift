//
//  LocalisedString+App.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 8/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

enum Localisations: String {
    
    case selectBloodTypeTitle = "LOCALKEY_SelectBloodTypeTitle"
	case selectLocationTitle = "LOCALKEY_SelectLocationTitle"
    case minimumLocationCharSearch = "LOCALKEY_MinimumLocationCharSearch"
    case searching = "LOCALKEY_Searching"
    case unknownError = "LOCALKEY_UnknownError"
    case unknownBloodType = "LOCALKEY_UnknownBloodType"
    case unknownLocation = "LOCALKEY_UnknownLocation"
    case notificationRegistrationError = "LOCALKEY_NotificationRegistrationError"
    case locationNotFound = "LOCALKEY_LocationNotFound"
    case alertDismiss = "LOCALKEY_AlertDismiss"
    case alertOk = "LOCALKEY_AlertOk"
    case alertCancel = "LOCALKEY_AlertCancel"
    case alertTitleError = "LOCALKEY_AlertTitleError"
    case alertTitleWarning = "LOCALKEY_AlertTitleWarning";
    case alertMsgUnRegister = "LOCALKEY_AlertMessageUnRegister"
    case unsubscribeMissingData = "LOCALKEY_UnsubscribeMissingData"
    case unsubscribeNoNetwork = "LOCALKEY_UnsubscribeNoNetwork"
    case unsubscribeCannotDetectNetwork = "LOCALKEY_UnsubscribeCannotDetectNetwork"
	case subscribeInfo = "LOCALKEY_SubscribeInfo"
	case unsubscribeInfo = "LOCALKEY_UnsubscribeInfo"
    
    
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
