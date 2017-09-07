//
//  BloodTypeStorageTests.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import XCTest
@testable import BloodDonationIOS

class BloodTypeStorageTests: XCTestCase {
    
    func test_StorageValue_oNegative() {
        let bloodType = BloodType.oNegative
        XCTAssertEqual(bloodType.storageValue(), "O-")
        XCTAssertTrue(BloodType.bloodTypeFromStorageValue("O-") == BloodType.oNegative)
    }

    func test_StorageValue_oPositive() {
        let bloodType = BloodType.oPositive
        XCTAssertEqual(bloodType.storageValue(), "O+")
        XCTAssertTrue(BloodType.bloodTypeFromStorageValue("O+") == BloodType.oPositive)
    }

    func test_StorageValue_aNegative() {
        let bloodType = BloodType.aNegative
        XCTAssertEqual(bloodType.storageValue(), "A-")
        XCTAssertTrue(BloodType.bloodTypeFromStorageValue("A-") == BloodType.aNegative)
    }
    
    func test_StorageValue_aPositive() {
        let bloodType = BloodType.aPositive
        XCTAssertEqual(bloodType.storageValue(), "A+")
        XCTAssertTrue(BloodType.bloodTypeFromStorageValue("A+") == BloodType.aPositive)
    }

    func test_StorageValue_bNegative() {
        let bloodType = BloodType.bNegative
        XCTAssertEqual(bloodType.storageValue(), "B-")
        XCTAssertTrue(BloodType.bloodTypeFromStorageValue("B-") == BloodType.bNegative)
    }
    
    func test_StorageValue_bPositive() {
        let bloodType = BloodType.bPositive
        XCTAssertEqual(bloodType.storageValue(), "B+")
        XCTAssertTrue(BloodType.bloodTypeFromStorageValue("B+") == BloodType.bPositive)
    }

    func test_StorageValue_abNegative() {
        let bloodType = BloodType.abNegative
        XCTAssertEqual(bloodType.storageValue(), "AB-")
        XCTAssertTrue(BloodType.bloodTypeFromStorageValue("AB-") == BloodType.abNegative)
    }
    
    func test_StorageValue_abPositive() {
        let bloodType = BloodType.abPositive
        XCTAssertEqual(bloodType.storageValue(), "AB+")
        XCTAssertTrue(BloodType.bloodTypeFromStorageValue("AB+") == BloodType.abPositive)
    }

    func test_StorageValue_incorrectValue_returnsNil() {
        XCTAssertNil(BloodType.bloodTypeFromStorageValue("wronge"))
    }

}
