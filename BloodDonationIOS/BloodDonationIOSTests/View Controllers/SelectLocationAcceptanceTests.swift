//
//  SelectLocationAcceptanceTests.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 22/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import XCTest
@testable import BloodDonationIOS


class SelectLocationAcceptanceTests: AcceptanceTest {
    
    let dummyShowRegistrationAction = ShowRegistrationAction(bloodType: .aPositive) { _, _ in }
    
    
    func test_viewWillAppear_sendCorrectReportingData() {
        let viewController = viewControllerFactory.locationSelector(showRegistrationAction: dummyShowRegistrationAction)
        enumatorShowingViewController(viewController)
        XCTAssertEqual(stubAnalyticsReporting.loggedEvents.count, 1)
        XCTAssertEqual(stubAnalyticsReporting.loggedEvents[0].name, .showingLocationSelector)
        XCTAssertNil(stubAnalyticsReporting.loggedEvents[0].parameters)
    }
    
    
    func test_viewWillAppear_calledTwice_sendCorrectReportingDataTwice() {
        let viewController = viewControllerFactory.locationSelector(showRegistrationAction: dummyShowRegistrationAction)
        enumatorShowingViewController(viewController)
        viewController.viewWillAppear(false)        
        XCTAssertEqual(stubAnalyticsReporting.loggedEvents.count, 2)
        XCTAssertEqual(stubAnalyticsReporting.loggedEvents[1].name, .showingLocationSelector)
        XCTAssertNil(stubAnalyticsReporting.loggedEvents[1].parameters)
    }

}
