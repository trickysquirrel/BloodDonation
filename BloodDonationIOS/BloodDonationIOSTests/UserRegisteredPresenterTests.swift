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

    
    override func setUp() {
        super.setUp()
        let stubPersistentStorage = StubPersistentStorage()
        userStorage = UserPersistentStorage(userDefaultsPersistentStorage: stubPersistentStorage)
        stubMessagingSubscriber = StubMessagingSubscriber()
        presenter = UserRegisteredPresenter(userStorage: userStorage, messagingSubscriber: stubMessagingSubscriber)
    }
    
    override func tearDown() {
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
        
        var viewModel: UserRegisteredViewModel?
        presenter.updateView( completion: { newViewModel in
            viewModel = newViewModel
        })
        
        XCTAssertEqual(viewModel!.bloodTypeTitle, "unknown")
        XCTAssertEqual(viewModel!.locationTitle, "unknown")
    }

    
    func test_updateView_storedUserInfo_returnsViewModelWithValuesFromPersistedData() {
        
        setStubbedUserPersistedInformation()

        var viewModel: UserRegisteredViewModel?
        presenter.updateView( completion: { newViewModel in
            viewModel = newViewModel
        })
        
        XCTAssertEqual(viewModel!.bloodTypeTitle, "B-")
        XCTAssertEqual(viewModel!.locationTitle, "AU, area, name")
    }
    
}


// MARK:- UpdateView

extension UserRegisteredPresenterTests {

    func test_resetUser_unSubscribesToAllTopics() {
        
        setStubbedUserPersistedInformation()

        presenter.resetUser()
        
        XCTAssertEqual(stubMessagingSubscriber.unsubscribeTopic.count, 4)
        XCTAssertEqual(stubMessagingSubscriber.unsubscribeTopic[0], "au/area/name/b-")
        XCTAssertEqual(stubMessagingSubscriber.unsubscribeTopic[1], "au/area/name")
        XCTAssertEqual(stubMessagingSubscriber.unsubscribeTopic[2], "au/area/b-")
        XCTAssertEqual(stubMessagingSubscriber.unsubscribeTopic[3], "au/area")
    }

    
    func test_resetUser_removedPersistedBloodTypeAndLocation() {
        
        setStubbedUserPersistedInformation()
        
        XCTAssertNotNil(userStorage.fetchBloodType())
        XCTAssertNotNil(userStorage.fetchLocation())

        presenter.resetUser()
        
        XCTAssertNil(userStorage.fetchBloodType())
        XCTAssertNil(userStorage.fetchLocation())
    }

}
