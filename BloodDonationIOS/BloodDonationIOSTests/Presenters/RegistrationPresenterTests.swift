//
//  RegistrationPresenterTests.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 17/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import XCTest
@testable import BloodDonationIOS


class RegistrationPresenterTests: XCTestCase {
    
    var expectedBloodType: BloodType!
    var expectedLocation: LocationModel!
    var presenter: RegistrationPresenter!
    var stubMessagingRegister: StubMessagingRegister!
    var stubMessagingSubscriber: StubMessagingSubscriber!
    var stubPersistenceStorage: StubPersistentStorage!
    var registerUser: RegisterUser!
    var userStorage: UserPersistentStorage!
    var stubReachability: StubReachability!
    
    override func setUp() {
        super.setUp()
        stubPersistenceStorage = StubPersistentStorage()
        expectedBloodType = BloodType.aNegative
        expectedLocation = LocationModel(name: "Eltham North", area:"New South Wales", countryCode: .AU)
        stubMessagingRegister = StubMessagingRegister()
        stubMessagingSubscriber = StubMessagingSubscriber()
        userStorage = UserPersistentStorage(userDefaultsPersistentStorage: stubPersistenceStorage)
        stubReachability = StubReachability()
        let messagingTopicManager = MessagingTopicManager(reachability: stubReachability, messagingTopicSubscriber: stubMessagingSubscriber)
        registerUser = RegisterUser(userStorage: userStorage, messagingTopicManager: messagingTopicManager, notificationRegister: stubMessagingRegister, bloodType: expectedBloodType, location: expectedLocation)
        presenter = RegistrationPresenter(notificationRegister: stubMessagingRegister, messagingSubscriber: stubMessagingSubscriber, registerUser: registerUser)
    }
    
    override func tearDown() {
        stubReachability = nil
        userStorage = nil
        registerUser = nil
        expectedLocation = nil
        expectedBloodType = nil
        stubMessagingRegister = nil
        stubMessagingSubscriber = nil
        stubPersistenceStorage = nil
        presenter = nil
        super.tearDown()
    }
    
    private func updateViewWithNewViewModel() -> UserDataViewModel! {
        var viewModel: UserDataViewModel!
        presenter.updateView { response in
            switch response {
            case .updateView(let newViewModel):
                viewModel = newViewModel
            default:
                break
            }
        }
        return viewModel
    }
    
    private func registerUserError() -> String! {
        var errorMessage: String!
        presenter.registerUser { response in
            switch response {
            case .error(let message):
                errorMessage = message
            default:
                break
            }
        }
        return errorMessage
    }

    private func registerUserSuccess() -> Bool {
        var success = false
        presenter.registerUser { response in
            switch response {
            case .registrationSuccess:
                success = true
            default:
                break
            }
        }
        return success
    }

}

// MARK: updateView

extension RegistrationPresenterTests {
    
    func test_updateView_providesCorrectViewModelValues() {
        let viewModel = updateViewWithNewViewModel()
        XCTAssertEqual(viewModel!.bloodTypeTitle, "A-")
        XCTAssertEqual(viewModel!.locationTitle, "AU, New South Wales, Eltham North")
    }
}

// MARK: registerUser

extension RegistrationPresenterTests {

    func test_registerUser_notifiationRegistrationError_returnErrorLocalisedString() {
        let expectedLocalisedErrorString = "expected"
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:expectedLocalisedErrorString])
        stubMessagingRegister.response = .error(error)
        let errorMessage = registerUserError()
        XCTAssertEqual(errorMessage, expectedLocalisedErrorString)
    }

    
    func test_registerUser_notifiationRegistrationErrorNil_returnDefaultErrorString() {
        stubMessagingRegister.response = .error(nil)
        let errorMessage = registerUserError()
        XCTAssertEqual(errorMessage, "unknown error please try again")
    }
    

    func test_registerUser_notigiationRegistrationError_doesNotUpdateUserPersistenceData() {
        stubMessagingRegister.response = .error(nil)
        _ = registerUserError()
        XCTAssertEqual(stubPersistenceStorage.dictionaryStorage.count, 0)
    }

    
    func test_registerUser_notifiationRegistrationSuccess_registersForLocationBloodTopicAndAllDevices() {
        stubMessagingRegister.response = .success
        _ = registerUserError()
        XCTAssertEqual(stubMessagingSubscriber.providedTopic.count, 4)
        XCTAssertEqual(stubMessagingSubscriber.providedTopic[0], "au_new.south.wales_eltham.north_a-")
        XCTAssertEqual(stubMessagingSubscriber.providedTopic[1], "au_new.south.wales_eltham.north")
        XCTAssertEqual(stubMessagingSubscriber.providedTopic[2], "au_new.south.wales_a-")
        XCTAssertEqual(stubMessagingSubscriber.providedTopic[3], "au_new.south.wales")
    }

    
    func test_registerUser_notifiationRegistrationSuccess_registerTopicSuccess_returnsSuccess() {
        stubMessagingRegister.response = .success
        let success = registerUserSuccess()
        XCTAssertTrue(success)
    }

    
    func test_registerUser_notifiationRegistrationSuccess_registerTopicSuccess_updateUserPersistenceData() {
        stubMessagingRegister.response = .success
        _ = registerUserSuccess()
        XCTAssertEqual(stubPersistenceStorage.dictionaryStorage.count, 4)
        XCTAssertEqual(stubPersistenceStorage.dictionaryStorage["UserDefaultsBloodKey"] as! String, "A-")
        XCTAssertEqual(stubPersistenceStorage.dictionaryStorage["UserDefaultsLocationCodeKey"] as! String, "AU")
        XCTAssertEqual(stubPersistenceStorage.dictionaryStorage["UserDefaultsLocationAreaKey"] as! String, "New South Wales")
        XCTAssertEqual(stubPersistenceStorage.dictionaryStorage["UserDefaultsLocationNameKey"] as! String, "Eltham North")
    }
    
    
    func test_registerUser_noReachabilityObjectProvided_returnsErrorMessageAndStoredDataNotStored() {
        stubMessagingRegister.response = .success
        
        let messagingTopicManager = MessagingTopicManager(reachability: nil, messagingTopicSubscriber: stubMessagingSubscriber)
        let registerUser = RegisterUser(userStorage: userStorage, messagingTopicManager: messagingTopicManager, notificationRegister: stubMessagingRegister, bloodType: expectedBloodType, location: expectedLocation)
        presenter = RegistrationPresenter(notificationRegister: stubMessagingRegister, messagingSubscriber: stubMessagingSubscriber, registerUser: registerUser)

        let errorMessage = registerUserError()
        
        XCTAssertEqual(errorMessage!, "Unable to detect network")
        XCTAssertNil(userStorage.fetchBloodType())
        XCTAssertNil(userStorage.fetchLocation())
    }
    
    
    func test_resetUser_noNetwork_returnsErrorMessageAndStoredDataNotStored() {
        stubMessagingRegister.response = .success
        stubReachability.isConnected = false
        let errorMessage = registerUserError()
        XCTAssertEqual(errorMessage!, "You must be connected to the network to unsubscribe")
        XCTAssertNil(userStorage.fetchBloodType())
        XCTAssertNil(userStorage.fetchLocation())
    }


}
