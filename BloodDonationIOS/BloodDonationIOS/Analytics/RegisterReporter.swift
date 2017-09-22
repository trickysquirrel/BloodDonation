//
//  RegisterReporter.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 22/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

struct RegisterReporter {
    
    let analyticsReporter: AnalyticsReporting
    let location: LocationModel
    let bloodType: BloodType
    
    func viewShown() {
        analyticsReporter.logEvent(name: .showingRegister, parameters: nil)
    }
    
    func didRegister() {
        let topic = MessagingTopicGenerator().fullTopic(location: location, blood: bloodType)
        analyticsReporter.logEvent(name: .userDidRegister, parameters: ["blood":bloodType.displayString(), "topic":topic])
    }
}
