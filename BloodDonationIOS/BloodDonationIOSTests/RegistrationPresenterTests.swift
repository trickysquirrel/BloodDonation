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
    var stubNotificationRegister: StubNotificationRegister!
    var stubMessagingSubscriber: StubMessagingSubscriber!
    var stubPersistenceStorage: StubPersistentStorage!
    var userPersistentStorage: UserPersistentStorage!
    
    override func setUp() {
        super.setUp()
        stubPersistenceStorage = StubPersistentStorage()
        userPersistentStorage = UserPersistentStorage(userDefaultsPersistentStorage: stubPersistenceStorage)
        stubMessagingSubscriber = StubMessagingSubscriber()
        stubNotificationRegister = StubNotificationRegister()
        expectedBloodType = BloodType.aNegative
        expectedLocation = LocationModel(name: "Eltham North", area:"Victoria", countryCode: .AU)
        presenter = RegistrationPresenter(bloodType: expectedBloodType, location: expectedLocation, notificationRegister: stubNotificationRegister, messagingSubscriber: stubMessagingSubscriber, userStorage: userPersistentStorage)
    }
    
    override func tearDown() {
        expectedLocation = nil
        expectedBloodType = nil
        stubNotificationRegister = nil
        stubMessagingSubscriber = nil
        stubPersistenceStorage = nil
        presenter = nil
        super.tearDown()
    }
    
    private func updateViewWithNewViewModel() -> RegistrationViewModel! {
        var viewModel: RegistrationViewModel!
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
        XCTAssertEqual(viewModel!.locationTitle, "AU, Victoria, Eltham North")
    }
}

// MARK: registerUser

extension RegistrationPresenterTests {

    func test_registerUser_notifiationRegistrationError_returnErrorLocalisedString() {
        let expectedLocalisedErrorString = "expected"
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:expectedLocalisedErrorString])
        stubNotificationRegister.response = .error(error)
        let errorMessage = registerUserError()
        XCTAssertEqual(errorMessage, expectedLocalisedErrorString)
    }

    func test_registerUser_notifiationRegistrationErrorNil_returnDefaultErrorString() {
        stubNotificationRegister.response = .error(nil)
        let errorMessage = registerUserError()
        XCTAssertEqual(errorMessage, "unknown error please try again")
    }

    func test_registerUser_notigiationRegistrationError_doesNotUpdateUserPersistenceData() {
        stubNotificationRegister.response = .error(nil)
        _ = registerUserError()
        XCTAssertEqual(stubPersistenceStorage.dictionaryStorage.count, 0)
    }

    func test_registerUser_notifiationRegistrationSuccess_registersForLocationBloodTopicAndAllDevices() {
        stubNotificationRegister.response = .success
        _ = registerUserError()
        XCTAssertEqual(stubMessagingSubscriber.providedTopic.count, 4)
        XCTAssertEqual(stubMessagingSubscriber.providedTopic[0], "au/victoria/eltham north/a-")
        XCTAssertEqual(stubMessagingSubscriber.providedTopic[1], "au/victoria/eltham north")
        XCTAssertEqual(stubMessagingSubscriber.providedTopic[2], "au/victoria/a-")
        XCTAssertEqual(stubMessagingSubscriber.providedTopic[3], "au/victoria")
    }

    func test_registerUser_notifiationRegistrationSuccess_registerTopicSuccess_returnsSuccess() {
        stubNotificationRegister.response = .success
        let success = registerUserSuccess()
        XCTAssertTrue(success)
    }

    func test_registerUser_notifiationRegistrationSuccess_registerTopicSuccess_updateUserPersistenceData() {
        stubNotificationRegister.response = .success
        _ = registerUserSuccess()
        XCTAssertEqual(stubPersistenceStorage.dictionaryStorage.count, 4)
        XCTAssertEqual(stubPersistenceStorage.dictionaryStorage["UserDefaultsBloodKey"] as! String, "A-")
        XCTAssertEqual(stubPersistenceStorage.dictionaryStorage["UserDefaultsLocationCodeKey"] as! String, "AU")
        XCTAssertEqual(stubPersistenceStorage.dictionaryStorage["UserDefaultsLocationAreaKey"] as! String, "Victoria")
        XCTAssertEqual(stubPersistenceStorage.dictionaryStorage["UserDefaultsLocationNameKey"] as! String, "Eltham North")
    }

}
