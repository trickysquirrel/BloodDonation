//
//  UserDefaultsStorageTests.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import XCTest
@testable import BloodDonationIOS


class UserDefaultsStorageTests: XCTestCase {
    
    var stubPersistentStorage: StubPersistentStorage!
    var userDefaultsStorage: UserPersistentStorage!
    
    override func setUp() {
        super.setUp()
        stubPersistentStorage = StubPersistentStorage()
        userDefaultsStorage = UserPersistentStorage(userDefaultsPersistentStorage: stubPersistentStorage)
    }
    
    override func tearDown() {
        stubPersistentStorage = nil
        stubPersistentStorage = nil
        super.tearDown()
    }
    
    func test_persistBloodType_setTheCorrectKeyAndValue() {
        userDefaultsStorage.persistBloodType(BloodType.bNegative)
        XCTAssertEqual(stubPersistentStorage.dictionaryStorage["UserDefaultsBloodKey"] as! String, "B-")
    }

    func test_fetchBloodType_bNegative_returnsCorrectEnum() {
        userDefaultsStorage.persistBloodType(BloodType.bNegative)
        let bloodType = userDefaultsStorage.fetchBloodType()
        XCTAssertEqual(bloodType, .bNegative)
    }
    
}
