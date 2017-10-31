//
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation
@testable import BloodDonationIOS


class StubRouterActionFactory: RouterActionFactoryProtocol {

    private(set) var didCallShowLocationActionWithCountryCode: CountryCode?

    func makeShowCountryCodeAction(performBlock: @escaping (BloodType) -> ()) -> ShowCountryCodeAction {
        return ShowCountryCodeAction(performBlock: { (bloodType) in
        })
    }

    func makeShowLocationAction(performBlock: @escaping ((BloodType, CountryCode)->())) -> ShowLocationAction {
        return ShowLocationAction(performBlock: { [weak self] bloodType, countryCode in
            self?.didCallShowLocationActionWithCountryCode = countryCode
        })
    }

    func makeShowRegistrationAction(bloodType: BloodType, countryCode: String, performBlock: @escaping ((BloodType, LocationModel)->())) -> ShowRegistrationAction {
        // todo write tests to pass in value
        return ShowRegistrationAction(bloodType: .abNegative, performBlock: { _, _ in })
    }

    func makeAction(performBlock: @escaping (()->())) -> Action {
        return Action(performBlock: {})
    }
}
