//
//  UserRegisteredReporter.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 22/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

struct UserRegisteredReporter {
    
    let analyticsReporter: AnalyticsReporting
    let location: LocationModel?
    let bloodType: BloodType?

    func viewShown() {
        analyticsReporter.logEvent(name: .showingUserRegistered, parameters: nil)
    }

    func userWantsToUnsubscribe() {
        analyticsReporter.logEvent(name: .userWantsToUnsubscribe, parameters: nil)
    }

    func userCancelsUnsubscribtion() {
        analyticsReporter.logEvent(name: .userCancelsUnsubscribtion, parameters: nil)
    }
    
    func userUnRegisterd() {
        guard let location = location, let bloodType = bloodType else { return }
        let topic = MessagingTopicGenerator().fullTopic(location: location, blood: bloodType)
        analyticsReporter.logEvent(name: .userUnRegisterd, parameters: ["blood":bloodType.displayString(), "topic":topic])
    }

}

