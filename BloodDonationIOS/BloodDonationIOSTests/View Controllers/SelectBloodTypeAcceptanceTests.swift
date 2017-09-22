//
//  BloodTypeCollectionViewControllerTests.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 22/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import XCTest
@testable import BloodDonationIOS


class SelectBloodTypeAcceptanceTests: XCTestCase {
    
    var viewControllerFactory: ViewControllerFactory!
    var stubAnalyticsReporting: StubAnalyticsReporting!
    
    override func setUp() {
        super.setUp()
        
        let stubMessagingRegister = StubMessagingRegister()
        let stubPersistentStorage = StubPersistentStorage()
        let stubReachability = StubReachability()
        stubAnalyticsReporting = StubAnalyticsReporting()
        let stubMessagingSubscriber = StubMessagingSubscriber()

        let userStorage = UserPersistentStorage(userDefaultsPersistentStorage: stubPersistentStorage)
        let messagingTopicManager = MessagingTopicManager(reachability: stubReachability, messagingTopicSubscriber: stubMessagingSubscriber)
        let userRegistered = UserRegistered(userStorage: userStorage, messagingTopicManager: messagingTopicManager)
        let reporterFactory = ReporterFactory(analyticsReporter: stubAnalyticsReporting)
        
        viewControllerFactory = ViewControllerFactory(messagingRegister: stubMessagingRegister, userStorage: userStorage, userRegistered: userRegistered, messagingTopicManager: messagingTopicManager, reporterFactory: reporterFactory)
    }
    
    override func tearDown() {
        stubAnalyticsReporting = nil
        viewControllerFactory = nil
        super.tearDown()
    }
    
    func enumatorShowingViewController(_ viewController: UIViewController) {
        // viewDidLoad and viewWillAppear
        viewController.beginAppearanceTransition(true, animated: false)
    }
}

// MARK: Reporting

extension SelectBloodTypeAcceptanceTests {
    
    func test_viewWillAppear_sendCorrectReportingData() {
        let action = ShowLocationAction { _ in }
        let viewController = viewControllerFactory.bloodTypeSelector(showLocationAction: action)

        enumatorShowingViewController(viewController)

        XCTAssertEqual(stubAnalyticsReporting.loggedEvents.count, 1)
        XCTAssertEqual(stubAnalyticsReporting.loggedEvents[0].name, .showingBloodTypeSelector)
        XCTAssertNil(stubAnalyticsReporting.loggedEvents[0].parameters)
    }

    func test_viewWillAppear_calledTwice_sendCorrectReportingDataTwice() {
        let action = ShowLocationAction { _ in }
        let viewController = viewControllerFactory.bloodTypeSelector(showLocationAction: action)

        enumatorShowingViewController(viewController)
        viewController.viewWillAppear(false)

        XCTAssertEqual(stubAnalyticsReporting.loggedEvents.count, 2)
        XCTAssertEqual(stubAnalyticsReporting.loggedEvents[1].name, .showingBloodTypeSelector)
        XCTAssertNil(stubAnalyticsReporting.loggedEvents[1].parameters)
    }

}
