//
//  AcceptanceTest.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 22/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import XCTest
@testable import BloodDonationIOS


class AcceptanceTest: XCTestCase {
    
    var viewControllerFactory: ViewControllerFactory!
    var stubAnalyticsReporting: StubAnalyticsReporting!
    var stubRouterActionFactory: StubRouterActionFactory!

    override func setUp() {
        super.setUp()
        
        let stubMessagingRegister = StubMessagingRegister()
        let stubPersistentStorage = StubPersistentStorage()
        let stubReachability = StubReachability()
        stubAnalyticsReporting = StubAnalyticsReporting()
        stubRouterActionFactory = StubRouterActionFactory()
        let stubMessagingSubscriber = StubMessagingSubscriber()
        
        let userStorage = UserPersistentStorage(userDefaultsPersistentStorage: stubPersistentStorage)
        let messagingTopicManager = MessagingTopicManager(reachability: stubReachability, messagingTopicSubscriber: stubMessagingSubscriber)
        let userRegistered = UserRegistered(userStorage: userStorage, messagingTopicManager: messagingTopicManager)
        let reporterFactory = ReporterFactory(analyticsReporter: stubAnalyticsReporting)
        
        viewControllerFactory = ViewControllerFactory(messagingRegister: stubMessagingRegister, userStorage: userStorage, userRegistered: userRegistered, messagingTopicManager: messagingTopicManager, reporterFactory: reporterFactory, routerActionsFactory: stubRouterActionFactory)
    }
    
    override func tearDown() {
        stubRouterActionFactory = nil
        stubAnalyticsReporting = nil
        viewControllerFactory = nil
        super.tearDown()
    }

}

// MARK:- Utils

extension AcceptanceTest {
    
    func enumatorShowingViewController(_ viewController: UIViewController) {
        // viewDidLoad and viewWillAppear
        viewController.beginAppearanceTransition(true, animated: false)
    }

}
