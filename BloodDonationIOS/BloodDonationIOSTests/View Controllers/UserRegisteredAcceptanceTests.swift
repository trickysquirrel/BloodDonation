//
//  UserRegisteredAcceptanceTests.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 22/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import XCTest
@testable import BloodDonationIOS


class UserRegisteredAcceptanceTests: AcceptanceTest {
    
    let dummyAction = Action { }

    
    func test_viewWillAppear_sendCorrectReportingData() {
        let viewController = viewControllerFactory.registeredUser(unreigisterAction: dummyAction)
        enumatorShowingViewController(viewController)
        XCTAssertEqual(stubAnalyticsReporting.loggedEvents.count, 1)
        XCTAssertEqual(stubAnalyticsReporting.loggedEvents[0].name, .showingUserRegistered)
        XCTAssertNil(stubAnalyticsReporting.loggedEvents[0].parameters)
    }
    
    
    func test_viewWillAppear_calledTwice_sendCorrectReportingDataTwice() {
        let viewController = viewControllerFactory.registeredUser(unreigisterAction: dummyAction)
        enumatorShowingViewController(viewController)
        viewController.viewWillAppear(false)        
        XCTAssertEqual(stubAnalyticsReporting.loggedEvents.count, 2)
        XCTAssertEqual(stubAnalyticsReporting.loggedEvents[1].name, .showingUserRegistered)
        XCTAssertEqual(stubAnalyticsReporting.loggedEvents[1].parameters["blood"] as! String, )
    }
    // analyticsReporter.logEvent(name: .userDidRegister, parameters: ["blood":bloodType.displayString(), "topic":topic])
}

