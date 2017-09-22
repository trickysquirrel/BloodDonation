//
//  RegisterAcceptanceTests.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 22/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import XCTest
@testable import BloodDonationIOS


class RegisterAcceptanceTests: AcceptanceTest {
    
    let dummyAction = Action{}
    
    func test_viewWillAppear_sendCorrectReportingData() {
        let viewController = viewControllerFactory.register(bloodType: .aNegative, location: LocationModel(name:"a", area:"b", countryCode:.AU), showUserRegisteredAction: dummyAction)        
        enumatorShowingViewController(viewController)
        XCTAssertEqual(stubAnalyticsReporting.loggedEvents.count, 1)
        XCTAssertEqual(stubAnalyticsReporting.loggedEvents[0].name, .showingRegister)
        XCTAssertNil(stubAnalyticsReporting.loggedEvents[0].parameters)
    }
    
    
    func test_viewWillAppear_calledTwice_sendCorrectReportingDataTwice() {
        let viewController = viewControllerFactory.register(bloodType: .aNegative, location: LocationModel(name:"a", area:"b", countryCode:.AU), showUserRegisteredAction: dummyAction)
        enumatorShowingViewController(viewController)
        viewController.viewWillAppear(false)
        XCTAssertEqual(stubAnalyticsReporting.loggedEvents.count, 2)
        XCTAssertEqual(stubAnalyticsReporting.loggedEvents[1].name, .showingRegister)
        XCTAssertNil(stubAnalyticsReporting.loggedEvents[1].parameters)
    }
    
    
    func test_userSelectedConfirmationButton_sendCorrectReportingData() {
        let viewController = viewControllerFactory.register(bloodType: .aNegative, location: LocationModel(name:"a", area:"b", countryCode:.AU), showUserRegisteredAction: dummyAction)
        enumatorShowingViewController(viewController)
        XCTAssertEqual(stubAnalyticsReporting.loggedEvents.count, 2)
        XCTAssertEqual(stubAnalyticsReporting.loggedEvents[1].name, .userDidRegister)
        XCTAssertNil(stubAnalyticsReporting.loggedEvents[1].parameters)
    }
    
}

