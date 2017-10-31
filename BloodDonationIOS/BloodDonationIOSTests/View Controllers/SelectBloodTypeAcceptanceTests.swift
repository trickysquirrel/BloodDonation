//
//  BloodTypeCollectionViewControllerTests.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 22/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import XCTest
@testable import BloodDonationIOS


//  Not really acceptance tests yet,
//  need to be able to....
//  test number of objects shown to user
//  selecting one of them results in a call to action etc
//  show alerts in correct conditions if there are any


class SelectBloodTypeAcceptanceTests: AcceptanceTest {
    
    let dummyShowLocationAction = ShowLocationAction { _,_ in }


    func test_viewWillAppear_sendCorrectReportingData() {
        let viewController = viewControllerFactory.bloodTypeSelector(showLocationAction: dummyShowLocationAction)
        enumatorShowingViewController(viewController)
        XCTAssertEqual(stubAnalyticsReporting.loggedEvents.count, 1)
        XCTAssertEqual(stubAnalyticsReporting.loggedEvents[0].name, .showingBloodTypeSelector)
        XCTAssertNil(stubAnalyticsReporting.loggedEvents[0].parameters)
    }
    
    func test_viewWillAppear_calledTwice_sendCorrectReportingDataTwice() {
        let viewController = viewControllerFactory.bloodTypeSelector(showLocationAction: dummyShowLocationAction)
        enumatorShowingViewController(viewController)
        viewController.viewWillAppear(false)        
        XCTAssertEqual(stubAnalyticsReporting.loggedEvents.count, 2)
        XCTAssertEqual(stubAnalyticsReporting.loggedEvents[1].name, .showingBloodTypeSelector)
        XCTAssertNil(stubAnalyticsReporting.loggedEvents[1].parameters)
    }
    
    // TODO: we add more test but will need to create a presenter factory to see can fake stuff
}


