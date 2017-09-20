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
//    var stubUserDefaultsStorage: StubPersistentStorage!
//    var userStorage: UserPersistentStorage!
    
    override func setUp() {
        super.setUp()
//        stubUserDefaultsStorage = StubPersistentStorage()
//        userStorage = UserPersistentStorage(userDefaultsPersistentStorage: stubUserDefaultsStorage)
//        let bloodTypeSetter = BloodTypeSetter(persistentStorage: userStorage)
        let bloodTypeFetcher = BloodTypeFetcher()
        presenter = BloodTypePresenter(bloodTypeFetcher: bloodTypeFetcher)
    }
    
    override func tearDown() {
        //stubUserDefaultsStorage = nil
        //userStorage = nil
        presenter = nil
        super.tearDown()
    }
    
//    func setUpStorageWithBloodType(_ bloodType: BloodType) {
//        userStorage.persistBloodType(bloodType)
//    }
}


// MARK: Update View

extension BloodTypePresenterTests {
    
    func test_updateView_returnsEightViewModels() {
        var returnedViewModels: [BloodTypeViewModel] = []
        presenter.onEventUpdate{ viewModels in
            returnedViewModels = viewModels
        }
        presenter.updateView()
        XCTAssertEqual(returnedViewModels.count, 8)
    }
    

    func test_updateView_noBloodTypePreviousSelected_returnsEightViewModelsWithCorrectLabels() {
        var returnedViewModels: [BloodTypeViewModel] = []
        presenter.onEventUpdate{ viewModels in
            returnedViewModels = viewModels
        }
        presenter.updateView()
        
        XCTAssertEqual(returnedViewModels[0].title, "O-")
        XCTAssertEqual(returnedViewModels[1].title, "O+")
        XCTAssertEqual(returnedViewModels[2].title, "A-")
        XCTAssertEqual(returnedViewModels[3].title, "A+")
        XCTAssertEqual(returnedViewModels[4].title, "B-")
        XCTAssertEqual(returnedViewModels[5].title, "B+")
        XCTAssertEqual(returnedViewModels[6].title, "AB-")
        XCTAssertEqual(returnedViewModels[7].title, "AB+")
    }
    

    func test_updateView_returnsEightViewModelsWithCorrectType() {
        var returnedViewModels: [BloodTypeViewModel] = []
        presenter.onEventUpdate{ viewModels in
            returnedViewModels = viewModels
        }
        presenter.updateView()
        
        XCTAssertEqual(returnedViewModels[0].type, .oNegative)
        XCTAssertEqual(returnedViewModels[1].type, .oPositive)
        XCTAssertEqual(returnedViewModels[2].type, .aNegative)
        XCTAssertEqual(returnedViewModels[3].type, .aPositive)
        XCTAssertEqual(returnedViewModels[4].type, .bNegative)
        XCTAssertEqual(returnedViewModels[5].type, .bPositive)
        XCTAssertEqual(returnedViewModels[6].type, .abNegative)
        XCTAssertEqual(returnedViewModels[7].type, .abPositive)
    }
     
    // This should be on the view controller
    func test_onCellSelection_passesCorrectBloodTypeToAction() {
        // TODO: create fake data source, for event to occur and check action is given correct value
    }
    
//    func test_updateView_oPositiveBloodSelected_returnsCorrectColorOnAllViewModels() {
//        setUpStorageWithBloodType(BloodType.oPositive)
//
//        var returnedViewModels: [BloodTypeViewModel] = []
//        presenter.onEventUpdate{ viewModels in
//            returnedViewModels = viewModels
//        }
//        presenter.updateView()
//
//        XCTAssertEqual(returnedViewModels[0].highlightColor, UIColor.bloodTypeUnfocused)
//        XCTAssertEqual(returnedViewModels[1].highlightColor, UIColor.bloodTypeFocused)
//        XCTAssertEqual(returnedViewModels[2].highlightColor, UIColor.bloodTypeUnfocused)
//        XCTAssertEqual(returnedViewModels[3].highlightColor, UIColor.bloodTypeUnfocused)
//        XCTAssertEqual(returnedViewModels[4].highlightColor, UIColor.bloodTypeUnfocused)
//        XCTAssertEqual(returnedViewModels[5].highlightColor, UIColor.bloodTypeUnfocused)
//        XCTAssertEqual(returnedViewModels[6].highlightColor, UIColor.bloodTypeUnfocused)
//        XCTAssertEqual(returnedViewModels[7].highlightColor, UIColor.bloodTypeUnfocused)
//    }

}

// MARK: Set blood type

//extension BloodTypePresenterTests {
//
//    func test_updateBloodType_setsCorrectValueInPersistentStorage() {
//        presenter.updateBloodType(BloodType.abNegative)
//        let storedBloodTypeValue = stubUserDefaultsStorage.dictionaryStorage["UserDefaultsBloodKey"] as? String
//        XCTAssertEqual(storedBloodTypeValue, "AB-")
//    }
//
//
//    func test_updateBloodType_callsUpdateEventBlock() {
//
//        var didCallUpdateEventBlock = false
//        presenter.onEventUpdate{ _ in
//            didCallUpdateEventBlock = true
//        }
//
//        presenter.updateBloodType(BloodType.abNegative)
//        XCTAssertTrue(didCallUpdateEventBlock)
//    }
//
//}

