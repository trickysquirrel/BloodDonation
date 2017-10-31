//
//  RouterTests.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 20/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import XCTest
@testable import BloodDonationIOS


class RouterTests: XCTestCase {

    private var stubUserStorage: UserPersistentStorage!
    private var userRegistered: UserRegistered!
    private var stubViewControllerFactory: StubViewControllerFactory!
    private var router: Router!

    
    override func setUp() {
        super.setUp()
        let stubPersistentStorage = StubPersistentStorage()
        let stubReachability = StubReachability()
        let messagingTopicSubscriber = MessagingTopicSubscriber()
        let messagingTopicManager = MessagingTopicManager(reachability: stubReachability, messagingTopicSubscriber: messagingTopicSubscriber)
        stubUserStorage = UserPersistentStorage(userDefaultsPersistentStorage: stubPersistentStorage)
        userRegistered = UserRegistered(userStorage: stubUserStorage, messagingTopicManager: messagingTopicManager)
        stubViewControllerFactory = StubViewControllerFactory()
		router = Router(window: UIWindow(), navigationController: UINavigationController(), viewControllerFactory: stubViewControllerFactory, userRegistered: userRegistered)
    }
    
    override func tearDown() {
        stubUserStorage = nil
        userRegistered = nil
        stubViewControllerFactory = nil
        router = nil
        super.tearDown()
    }
    
    func test_displayFirstViewController_notYetRegisteredUser_requestBloodTypeSelectorViewController() {
        router.displayFirstViewController()
        XCTAssertTrue(stubViewControllerFactory.didCallBloodTypeSelector)
    }

    func test_displayFirstViewController_withRegisteredUser_requestBloodTypeSelectorViewController() {
        stubUserStorage.persistBloodType(BloodType.bNegative)
        router.displayFirstViewController()
        XCTAssertTrue(stubViewControllerFactory.didCallRegisteredUser)
    }
}
