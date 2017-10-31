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
        let regionPicker = viewController.regionPicker!
        viewController.pickerView(regionPicker, didSelectRow: 0, inComponent: 0)
        XCTAssertNil(stubRouterActionFactory.didCallShowLocationActionWithCountryCode)
    }

    func test_didSelectRow_secondRow_doesCallToDisplayNextViewControllerWithCorrectCountryCode() {
        let regionPicker = viewController.regionPicker!
        viewController.pickerView(regionPicker, didSelectRow: 1, inComponent: 0)
        XCTAssertEqual(stubRouterActionFactory.didCallShowLocationActionWithCountryCode, .AU)
    }

}
