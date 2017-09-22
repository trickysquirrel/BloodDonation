//
//  StubAnalyticsReporter.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 22/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation
@testable import BloodDonationIOS


struct StubAnalyticsReportingEvent {
    let name: AnalyticsEventName
    let parameters: [String:Any]?
}


class StubAnalyticsReporting: AnalyticsReporting {
    
    private(set) var loggedEvents = [StubAnalyticsReportingEvent]()
    
    func logEvent(name: AnalyticsEventName, parameters:[String:Any]?) {
        loggedEvents.append(StubAnalyticsReportingEvent(name: name, parameters: parameters))
    }
}
