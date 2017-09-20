//
//  MessagingTopicGenerator.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 20/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

struct MessagingTopicGenerator {
    
    func allTopics(location: LocationModel, blood: BloodType) -> [String] {
        return [
            makeAreaNameBloodTopicTitle(location: location, bloodType: blood),
            makeAreaNameTopicTitle(location: location, bloodType: blood),
            makeAreaBloodTopicTitle(location: location, bloodType: blood),
            makeAreaTopicTitle(location: location, bloodType: blood)
            ]
    }
    
}

// MARK: Utils

private extension MessagingTopicGenerator {
    
    private func makeAreaNameBloodTopicTitle(location: LocationModel, bloodType: BloodType) -> String {
        let upperCaseString = location.countryCode.rawValue + "/" + location.area + "/" + location.name + "/" + bloodType.displayString()
        return upperCaseString.lowercased()
    }
    
    private func makeAreaNameTopicTitle(location: LocationModel, bloodType: BloodType) -> String {
        let upperCaseString = location.countryCode.rawValue + "/" + location.area + "/" + location.name
        return upperCaseString.lowercased()
    }
    
    private func makeAreaBloodTopicTitle(location: LocationModel, bloodType: BloodType) -> String {
        let upperCaseString = location.countryCode.rawValue + "/" + location.area + "/" + bloodType.displayString()
        return upperCaseString.lowercased()
    }
    
    private func makeAreaTopicTitle(location: LocationModel, bloodType: BloodType) -> String {
        let upperCaseString = location.countryCode.rawValue + "/" + location.area
        return upperCaseString.lowercased()
    }

}
