//
//  UserRegisteredPresenterTests.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 20/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import XCTest
@testable import BloodDonationIOS


class UserRegisteredPresenterTests: XCTestCase {
    
    var userStorage: UserPersistentStorage!
    var presenter: UserRegisteredPresenter!
    var stubMessagingSubscriber: StubMessagingSubscriber!
    var stubReachability: StubReachability!
    var messagingTopicManager: MessagingTopicManager!
    var userRegistered: UserRegistered!

    
    override func setUp() {
        super.setUp()
        stubReachability = StubReachability()
        let stubPersistentStorage = StubPersistentStorage()
        userStorage = UserPersistentStorage(userDefaultsPersistentStorage: stubPersistentStorage)
        stubMessagingSubscriber = StubMessagingSubscriber()
        messagingTopicManager = MessagingTopicManager(reachability: stubReachability, messagingTopicSubscriber: stubMessagingSubscriber)
        userRegistered = UserRegistered(userStorage: userStorage, messagingTopicManager: messagingTopicManager)
        presenter = UserRegisteredPresenter(userRegistered: userRegistered)
    }
    
    override func tearDown() {
        userRegistered = nil
        messagingTopicManager = nil
        stubReachability = nil
        stubMessagingSubscriber = nil
        userStorage = nil
        presenter = nil
        super.tearDown()
    }
    
    func setStubbedUserPersistedInformation() {
        userStorage.persistBloodType(.bNegative)
        userStorage.persistLocation(LocationModel(name:"name", area:"area", countryCode: CountryCode.AU))
    }
}

// MARK:- UpdateView

extension UserRegisteredPresenterTests {

    func test_updateView_noBloodStored_returnsViewModelWithDefaultValues() {
        
        var viewModel: UserDataViewModel?
        presenter.updateView( completion: { newViewModel in
            viewModel = newViewModel
        })
        
        XCTAssertEqual(viewModel!.bloodTypeTitle, "unknown")
        XCTAssertEqual(viewModel!.locationTitle, "unknown")
    }

    
    func test_updateView_storedUserInfo_returnsViewModelWithValuesFromPersistedData() {
        
        setStubbedUserPersistedInformation()

        var viewModel: UserDataViewModel?
        presenter.updateView( completion: { newViewModel in
            viewModel = newViewModel
        })
        
        XCTAssertEqual(viewModel!.bloodTypeTitle, "B-")
        XCTAssertEqual(viewModel!.locationTitle, "AU, area, name")
		XCTAssertEqual(viewModel!.informationText, "you are now registered to receive notifications in your region and blood type")
    }
    
}


// MARK:- Reset

extension UserRegisteredPresenterTests {

    func test_resetUser_missingStoredBloodType_deletesLocationAndReturnsNoError() {
        userStorage.persistLocation(LocationModel(name:"name", area:"area", countryCode: CountryCode.AU))
        let errorMessage = presenter.resetUser()
        XCTAssertNil(errorMessage)
        XCTAssertNil(userStorage.fetchBloodType())
        XCTAssertNil(userStorage.fetchLocation())
    }

    func test_resetUser_missingStoredLocation_deletesBloodTypeAndReturnsNoError() {
        userStorage.persistBloodType(.bNegative)
        let errorMessage = presenter.resetUser()
        XCTAssertNil(errorMessage)
        XCTAssertNil(userStorage.fetchBloodType())
        XCTAssertNil(userStorage.fetchLocation())
    }
    
    func test_resetUser_noReachabilityObjectProvided_returnsErrorMessageAndStoredDataNotDeleted() {
        setStubbedUserPersistedInformation()
        messagingTopicManager = MessagingTopicManager(reachability: nil, messagingTopicSubscriber: stubMessagingSubscriber)
        userRegistered = UserRegistered(userStorage: userStorage, messagingTopicManager: messagingTopicManager)
        presenter = UserRegisteredPresenter(userRegistered: userRegistered)
        let errorMessage = presenter.resetUser()
        XCTAssertEqual(errorMessage!, "Unable to detect network")
        XCTAssertNotNil(userStorage.fetchBloodType())
        XCTAssertNotNil(userStorage.fetchLocation())
    }
    
    func test_resetUser_noNetwork_returnsErrorMessageAndStoredDataNotDeleted() {
        stubReachability.isConnected = false
        setStubbedUserPersistedInformation()
        let errorMessage = presenter.resetUser()
        XCTAssertEqual(errorMessage!, "You must be connected to the network to unsubscribe")
        XCTAssertNotNil(userStorage.fetchBloodType())
        XCTAssertNotNil(userStorage.fetchLocation())
    }

    func test_resetUser_unSubscribesToAllTopics() {
        
        setStubbedUserPersistedInformation()
        _ = presenter.resetUser()
        
        XCTAssertEqual(stubMessagingSubscriber.unsubscribeTopic.count, 4)
        XCTAssertEqual(stubMessagingSubscriber.unsubscribeTopic[0], "au_area_name_b-")
        XCTAssertEqual(stubMessagingSubscriber.unsubscribeTopic[1], "au_area_name")
        XCTAssertEqual(stubMessagingSubscriber.unsubscribeTopic[2], "au_area_b-")
        XCTAssertEqual(stubMessagingSubscriber.unsubscribeTopic[3], "au_area")
    }

    
    func test_resetUser_removedPersistedBloodTypeAndLocation() {
        
        setStubbedUserPersistedInformation()
        
        XCTAssertNotNil(userStorage.fetchBloodType())
        XCTAssertNotNil(userStorage.fetchLocation())

        _ = presenter.resetUser()
        
        XCTAssertNil(userStorage.fetchBloodType())
        XCTAssertNil(userStorage.fetchLocation())
    }

}
