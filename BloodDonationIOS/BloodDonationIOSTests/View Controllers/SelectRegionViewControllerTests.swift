//
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import XCTest
@testable import BloodDonationIOS


class SelectRegionViewControllerTests: AcceptanceTest {

    var viewController: SelectRegionViewController!

    override func setUp() {
        super.setUp()
        let action = stubRouterActionFactory.makeShowLocationAction { (_,_) in }
        viewController = viewControllerFactory.regionSelector(showLocationAction: action) as! SelectRegionViewController
        viewController.beginAppearanceTransition(true, animated: false)
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
}

extension SelectRegionViewControllerTests {

    func test_onViewDidLoad_hasCorrectTitle() {
        XCTAssertEqual(viewController.title, "Select Region")
    }


    func test_onViewDidLoad_pickerContainsCorrectNumberOfItemsAndComponents() {
        let regionPicker = viewController.regionPicker!
        XCTAssertEqual(regionPicker.numberOfComponents, 1)
        XCTAssertEqual(regionPicker.numberOfRows(inComponent: 0), 3)
    }

    func test_onViewDidLoad_regionPickerHasFirstTwoTitleCorrect() {
        let regionPicker = viewController.regionPicker!
        XCTAssertEqual(viewController.pickerView(regionPicker, titleForRow: 0, forComponent: 0), " - ")
        XCTAssertEqual(viewController.pickerView(regionPicker, titleForRow: 1, forComponent: 0), "Australia")
    }

    func test_didSelectRow_firstRow_doesNotCallToDisplayNextViewController() {
        viewController.userDidSelectConfirmButton()
        XCTAssertNil(stubRouterActionFactory.didCallShowLocationActionWithCountryCode)
    }

    func test_didSelectRow_secondRow_doesCallToDisplayNextViewControllerWithCorrectCountryCode() {
        // switch the picker view so we can stub the selected row
        let stubPickerView = StubPickerView()
        stubPickerView.stubbedSelectedRow = 1
        viewController.regionPicker = stubPickerView

        viewController.userDidSelectConfirmButton()

        XCTAssertEqual(stubRouterActionFactory.didCallShowLocationActionWithCountryCode, .AU)
    }

}
