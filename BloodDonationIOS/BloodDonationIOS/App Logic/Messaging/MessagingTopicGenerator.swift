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
            makeAreaNameBloodTopic(location: location, bloodType: blood),
            makeAreaNameTopic(location: location, bloodType: blood),
            makeAreaBloodTopic(location: location, bloodType: blood),
            makeAreaTopic(location: location, bloodType: blood)
            ]
    }
    
}

// MARK: Utils

private extension MessagingTopicGenerator {
    
    private func seperator() -> String {
        // cannot use characters like '/' please check before changing
        return "_"
    }
    
    private func makeAreaNameBloodTopic(location: LocationModel, bloodType: BloodType) -> String {
        let upperCaseString = location.countryCode.rawValue + seperator() + location.area + seperator() + location.name + seperator() + bloodType.displayString()
        return upperCaseString.lowercased()
    }
    
    private func makeAreaNameTopic(location: LocationModel, bloodType: BloodType) -> String {
        let upperCaseString = location.countryCode.rawValue + seperator() + location.area + seperator() + location.name
        return upperCaseString.lowercased()
    }
    
    private func makeAreaBloodTopic(location: LocationModel, bloodType: BloodType) -> String {
        let upperCaseString = location.countryCode.rawValue + seperator() + location.area + seperator() + bloodType.displayString()
        return upperCaseString.lowercased()
    }
    
    private func makeAreaTopic(location: LocationModel, bloodType: BloodType) -> String {
        let upperCaseString = location.countryCode.rawValue + seperator() + location.area
        return upperCaseString.lowercased()
    }

}
