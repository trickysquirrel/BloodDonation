//
//  SelectBloodReporter.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 22/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation


struct SelectBloodReporter {
    
    let analyticsReporter: AnalyticsReporting
    
    func viewShown() {
        analyticsReporter.logEvent(name: .showingBloodTypeSelector, parameters: nil)
    }
}
