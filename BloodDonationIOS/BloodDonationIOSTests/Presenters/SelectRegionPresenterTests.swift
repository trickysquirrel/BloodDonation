//
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import XCTest
@testable import BloodDonationIOS


class SelectRegionPresenterTests: XCTestCase {

    var presenter: SelectRegionPresenter!
    
    override func setUp() {
        super.setUp()
        presenter = SelectRegionPresenter()
    }
    
    override func tearDown() {
        presenter = nil
        super.tearDown()
    }


    func test_navigationTitle_returnsCorrectValue() {
        XCTAssertEqual(presenter.navigationTitle(), "Select Region")
    }

    func test_updateView_returnsSuccessWithCorrectViewModels() {
        let viewModels = presenter.updateView()
        XCTAssertEqual(viewModels.count, 3)
    }

    func test_updateView_returnsFirstViewModelAsNonSelectable() {
        let viewModels = presenter.updateView()
        XCTAssertEqual(viewModels[0].title, " - ")
        XCTAssertEqual(viewModels[0].countryCode, .unknown)
    }

    func test_updateView_returnsCorrectCountryNamesInCorrectOrder() {
        let viewModels = presenter.updateView()
        XCTAssertEqual(viewModels[1].title, "Australia")
        XCTAssertEqual(viewModels[1].countryCode, .AU)
        XCTAssertEqual(viewModels[2].title, "New Zeland")
        XCTAssertEqual(viewModels[2].countryCode, .NZ)
    }

}
