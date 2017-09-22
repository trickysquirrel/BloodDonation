//
//  AnalyticsReporterFactory.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 22/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation


struct ReporterFactory {
    
    let analyticsReporter: AnalyticsReporting
    
    func makeSelectBloodReporter() -> SelectBloodReporter {
        return SelectBloodReporter(analyticsReporter: analyticsReporter)
    }

    func makeSelectLocationReporter() -> LocationReporter {
        return LocationReporter(analyticsReporter: analyticsReporter)
    }

    func makeRegisterReporterReporter(location: LocationModel, bloodType: BloodType) -> RegisterReporter {
        return RegisterReporter(analyticsReporter: analyticsReporter, location: location, bloodType: bloodType)
    }

    func makeUserRegisteredReporter(location: LocationModel?, bloodType: BloodType?) -> UserRegisteredReporter {
        return UserRegisteredReporter(analyticsReporter: analyticsReporter, location: location, bloodType: bloodType)
    }
}
