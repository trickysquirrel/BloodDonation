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
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_updateView_providesCorrectViewModelValues() {
        let expectedBloodType = BloodType.aNegative
        let expectedLocation = LocationModel(name: "Eltham", area:"Victoria", countryCode: .AU)
        let presenter = RegistrationPresenter(bloodType: expectedBloodType, location: expectedLocation)
        let viewModel = presenter.updateView()
        XCTAssertEqual(viewModel.bloodTypeTitle, "A-")
        XCTAssertEqual(viewModel.locationTitle, "AU, Victoria, Eltham")
    }
    
    
    func test_registration_notigiationRegistrationError_returnErrorString() {
    }

    func test_registration_notigiationRegistrationError_doesNotUpdateUserPersistenceData() {
    }

    func test_registration_notifiationRegistrationSuccess_registerTopicError_returnsErrorString() {
    }

    func test_registration_notifiationRegistrationSuccess_registerTopicError_doesNotUpdateUserPersistenceData() {
    }

    func test_registration_notifiationRegistrationSuccess_registerTopicSuccess_returnsSuccessString() {
    }

    func test_registration_notifiationRegistrationSuccess_registerTopicSuccess_updateUserPersistenceData() {
    }

}
