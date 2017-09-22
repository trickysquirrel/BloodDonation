//
//  MessagingTopicGenerator.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 20/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation


struct MessagingTopicGenerator {
    
    private var seperator = "_"
    private var spaceReplacement = "."
    
    func allTopics(location: LocationModel, blood: BloodType) -> [String] {
        return [
            makeAreaNameBloodTopic(location: location, bloodType: blood),
            makeAreaNameTopic(location: location, bloodType: blood),
            makeAreaBloodTopic(location: location, bloodType: blood),
            makeAreaTopic(location: location, bloodType: blood)
            ]
    }
    
    func fullTopic(location: LocationModel, blood: BloodType) -> String {
        return makeAreaNameBloodTopic(location: location, bloodType: blood)
    }
    
}

// MARK: Utils

private extension MessagingTopicGenerator {
    
    private func makeAreaNameBloodTopic(location: LocationModel, bloodType: BloodType) -> String {
        let upperCaseString = location.countryCode.rawValue + seperator + topic(location.area) + seperator + topic(location.name) + seperator + bloodType.displayString()
        return upperCaseString.lowercased()
    }
    
    private func makeAreaNameTopic(location: LocationModel, bloodType: BloodType) -> String {
        let upperCaseString = location.countryCode.rawValue + seperator + topic(location.area) + seperator + topic(location.name)
        return upperCaseString.lowercased()
    }
    
    private func makeAreaBloodTopic(location: LocationModel, bloodType: BloodType) -> String {
        let upperCaseString = location.countryCode.rawValue + seperator + topic(location.area) + seperator + bloodType.displayString()
        return upperCaseString.lowercased()
    }
    
    private func makeAreaTopic(location: LocationModel, bloodType: BloodType) -> String {
        let upperCaseString = location.countryCode.rawValue + seperator + topic(location.area)
        return upperCaseString.lowercased()
    }
    
    private func topic(_ string: String) -> String {
        return string.replacingOccurrences(of: " ", with: spaceReplacement)
    }

}
