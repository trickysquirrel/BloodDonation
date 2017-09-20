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

    func test_persistLocation_setTheCorrectKeyAndValue() {
        let location = LocationModel(name: "Name", area: "area", countryCode: .AU)
        userDefaultsStorage.persistLocation(location)
        XCTAssertEqual(stubPersistentStorage.dictionaryStorage["UserDefaultsLocationCodeKey"] as! String, "AU")
        XCTAssertEqual(stubPersistentStorage.dictionaryStorage["UserDefaultsLocationAreaKey"] as! String, "area")
        XCTAssertEqual(stubPersistentStorage.dictionaryStorage["UserDefaultsLocationNameKey"] as! String, "Name")
    }
    
    func test_fetchLocation_returnsCorrectEnum() {
        let expectedlocation = LocationModel(name: "Name", area: "area", countryCode: .AU)
        userDefaultsStorage.persistLocation(expectedlocation)
        let location = userDefaultsStorage.fetchLocation()
        XCTAssertEqual(location!.name, expectedlocation.name)
        XCTAssertEqual(location!.area, expectedlocation.area)
        XCTAssertEqual(location!.countryCode, expectedlocation.countryCode)
    }
    
    func test_hasPersistedData_noData_returnsFalse() {
        let hasPersistedData = userDefaultsStorage.hasPersistedData()
        XCTAssertFalse(hasPersistedData)
    }

    func test_hasPersistedData_withData_returnsTrue() {
        userDefaultsStorage.persistBloodType(BloodType.bNegative)
        let hasPersistedData = userDefaultsStorage.hasPersistedData()
        XCTAssertTrue(hasPersistedData)
    }

    func test_deleteAllData_removesAllData() {
        
        userDefaultsStorage.persistBloodType(BloodType.bNegative)
        let location = LocationModel(name: "Name", area: "area", countryCode: .AU)
        userDefaultsStorage.persistLocation(location)
        
        // check they where first added
        XCTAssertEqual(stubPersistentStorage.dictionaryStorage.count, 4)
        XCTAssertNotNil(stubPersistentStorage.dictionaryStorage["UserDefaultsBloodKey"])
        XCTAssertNotNil(stubPersistentStorage.dictionaryStorage["UserDefaultsLocationNameKey"])
        XCTAssertNotNil(stubPersistentStorage.dictionaryStorage["UserDefaultsLocationAreaKey"])
        XCTAssertNotNil(stubPersistentStorage.dictionaryStorage["UserDefaultsLocationCodeKey"])

        userDefaultsStorage.deleteAllData()
        
        // check they have now been removed
        XCTAssertEqual(stubPersistentStorage.dictionaryStorage.count, 0)
        XCTAssertNil(stubPersistentStorage.dictionaryStorage["UserDefaultsBloodKey"])
        XCTAssertNil(stubPersistentStorage.dictionaryStorage["UserDefaultsLocationNameKey"])
        XCTAssertNil(stubPersistentStorage.dictionaryStorage["UserDefaultsLocationAreaKey"])
        XCTAssertNil(stubPersistentStorage.dictionaryStorage["UserDefaultsLocationCodeKey"])
    }
    
}
