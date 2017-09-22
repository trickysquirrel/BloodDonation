//
//  AnalyticsReporter.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 22/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation
import Firebase

enum AnalyticsEventName: String {
    case showingBloodTypeSelector
    case showingLocationSelector
    case showingRegister
    case userDidRegister
    case showingUserRegistered
    case userWantsToUnsubscribe
    case userCancelsUnsubscribtion
    case userUnRegisterd
}

protocol AnalyticsReporting {
    func logEvent(name: AnalyticsEventName, parameters:[String:Any]?)
}

struct AnalyticsReporter: AnalyticsReporting {
    
    func logEvent(name: AnalyticsEventName, parameters:[String:Any]?) {
        Analytics.logEvent(name.rawValue, parameters: parameters)
    }
}
