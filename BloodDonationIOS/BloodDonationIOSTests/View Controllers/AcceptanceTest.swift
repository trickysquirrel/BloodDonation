//
//  AcceptanceTest.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 22/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import XCTest
@testable import BloodDonationIOS

class StubRouterActionFactory: RouterActionFactoryProtocol {

    private(set) var didCallShowLocationActionWithCountryCode: CountryCode?

    func makeShowCountryCodeAction(bloodType: BloodType, performBlock: @escaping (BloodType, CountryCode) -> ()) -> ShowCountryCodeAction {
        return ShowCountryCodeAction(bloodType: bloodType, performBlock: { (bloodType, countryCode) in
        })
    }

    func makeShowLocationAction(performBlock: @escaping ((BloodType, CountryCode)->())) -> ShowLocationAction {
        return ShowLocationAction(performBlock: { [weak self] bloodType, countryCode in
            self?.didCallShowLocationActionWithCountryCode = countryCode
        })
    }

    func makeShowRegistrationAction(bloodType: BloodType, countryCode: String, performBlock: @escaping ((BloodType, LocationModel)->())) -> ShowRegistrationAction {
        // todo write tests to pass in value
        return ShowRegistrationAction(bloodType: .abNegative, performBlock: { _, _ in })
    }

    func makeAction(performBlock: @escaping (()->())) -> Action {
        return Action(performBlock: {})
    }
}


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
