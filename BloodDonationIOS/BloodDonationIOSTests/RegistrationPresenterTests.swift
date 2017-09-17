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
    
    override func setUp() {
        super.setUp()
        stubMessagingSubscriber = StubMessagingSubscriber()
        stubNotificationRegister = StubNotificationRegister()
        expectedBloodType = BloodType.aNegative
        expectedLocation = LocationModel(name: "Eltham North", area:"Victoria", countryCode: .AU)
        presenter = RegistrationPresenter(bloodType: expectedBloodType, location: expectedLocation, notificationRegister: stubNotificationRegister, messagingSubscriber: stubMessagingSubscriber)
    }
    
    override func tearDown() {
        expectedLocation = nil
        expectedBloodType = nil
        stubNotificationRegister = nil
        stubMessagingSubscriber = nil
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
    
    func test_registerUser_notigiationRegistrationError_returnErrorString() {
        // set up error
        stubNotificationRegister.success = false
        let errorMessage = registerUserError()
        XCTAssertEqual(errorMessage, "You must allow notifications so that we can inform you when your blood type is required")
    }

    func test_registerUser_notigiationRegistrationError_doesNotUpdateUserPersistenceData() {
    }

    func test_registerUser_notifiationRegistrationSuccess_registersForTopic() {
        stubNotificationRegister.success = true
        _ = registerUserError()
        XCTAssertEqual(stubMessagingSubscriber.providedTopic, "au/victoria/eltham north/a-")
    }

    func test_registerUser_notifiationRegistrationSuccess_registerTopicError_doesNotUpdateUserPersistenceData() {
    }

    func test_registerUser_notifiationRegistrationSuccess_registerTopicSuccess_returnsSuccessString() {
    }

    func test_registerUser_notifiationRegistrationSuccess_registerTopicSuccess_updateUserPersistenceData() {
    }

}
