//
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation
import UIKit
@testable import BloodDonationIOS


class StubPickerView: UIPickerView {
    var stubbedSelectedRow: Int = 0

    override func selectedRow(inComponent component: Int) -> Int {
        return stubbedSelectedRow
    }
}
