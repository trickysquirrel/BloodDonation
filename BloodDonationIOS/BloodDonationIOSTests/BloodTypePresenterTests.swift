//
//  BloodTypePresenterTests.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import XCTest
@testable import BloodDonationIOS


class BloodTypePresenterTests: XCTestCase {
    
    var presenter: BloodTypePresenter!
    var stubUserDefaultsStorage: StubPersistentStorage!
    var userStorage: UserPersistentStorage!
    
    override func setUp() {
        super.setUp()
        stubUserDefaultsStorage = StubPersistentStorage()
        userStorage = UserPersistentStorage(userDefaultsPersistentStorage: stubUserDefaultsStorage)
        let bloodTypeSetter = BloodTypeSetter(persistentStorage: userStorage)
        let bloodTypeSelection = BloodTypeFetcher(persistentStorage: userStorage)
        presenter = BloodTypePresenter(bloodTypeSelection: bloodTypeSelection, bloodTypeSetter: bloodTypeSetter)
    }
    
    override func tearDown() {
        stubUserDefaultsStorage = nil
        userStorage = nil
        presenter = nil
        super.tearDown()
    }
    
    func setUpStorageWithBloodType(_ bloodType: BloodType) {
        userStorage.persistBloodType(bloodType)
    }
}


// MARK: Update View

extension BloodTypePresenterTests {
    
    func test_updateView_returnsEightViewModels() {
        let viewModels = presenter.updateView()
        XCTAssertEqual(viewModels.count, 8)
    }

    func test_updateView_noBloodTypePreviousSelected_returnsEightViewModelsWithCorrectLabels() {
        let viewModels = presenter.updateView()
        XCTAssertEqual(viewModels[0].title, "O-")
        XCTAssertEqual(viewModels[1].title, "O+")
        XCTAssertEqual(viewModels[2].title, "A-")
        XCTAssertEqual(viewModels[3].title, "A+")
        XCTAssertEqual(viewModels[4].title, "B-")
        XCTAssertEqual(viewModels[5].title, "B+")
        XCTAssertEqual(viewModels[6].title, "AB-")
        XCTAssertEqual(viewModels[7].title, "AB+")
    }
    
    func test_updateView_noBloodTypePreviousSelected_returnsEightViewModelsWithUnfocusedColor() {
        let viewModels = presenter.updateView()
        for viewModel in viewModels {
            XCTAssertEqual(viewModel.highlightColor, UIColor.bloodTypeUnfocused)
        }
    }

    func test_updateView_oPositiveBloodSelected_returnsCorrectColorOnAllViewModels() {
        setUpStorageWithBloodType(BloodType.oPositive)
        let viewModels = presenter.updateView()
        XCTAssertEqual(viewModels[0].highlightColor, UIColor.bloodTypeUnfocused)
        XCTAssertEqual(viewModels[1].highlightColor, UIColor.bloodTypeFocused)
        XCTAssertEqual(viewModels[2].highlightColor, UIColor.bloodTypeUnfocused)
        XCTAssertEqual(viewModels[3].highlightColor, UIColor.bloodTypeUnfocused)
        XCTAssertEqual(viewModels[4].highlightColor, UIColor.bloodTypeUnfocused)
        XCTAssertEqual(viewModels[5].highlightColor, UIColor.bloodTypeUnfocused)
        XCTAssertEqual(viewModels[6].highlightColor, UIColor.bloodTypeUnfocused)
        XCTAssertEqual(viewModels[7].highlightColor, UIColor.bloodTypeUnfocused)
    }

}

// MARK: Set blood type

extension BloodTypePresenterTests {
    
    func test_setBloodType_setsCorrectValueInPersistentStorage() {
        presenter.setBloodType(BloodType.abNegative)
        let storedBloodTypeValue = stubUserDefaultsStorage.dictionaryStorage["UserDefaultsBloodKey"] as? String
        XCTAssertEqual(storedBloodTypeValue, "AB-")
    }
}
