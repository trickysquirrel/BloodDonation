//
//  RouterActions.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 8/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation


protocol RouterActionFactoryProtocol {
    func makeShowCountryCodeAction(bloodType: BloodType, performBlock: @escaping (BloodType, CountryCode)->()) -> ShowCountryCodeAction
    func makeShowLocationAction(performBlock: @escaping (BloodType, CountryCode)->()) -> ShowLocationAction
    func makeShowRegistrationAction(bloodType: BloodType, countryCode: String, performBlock: @escaping ((BloodType, LocationModel)->())) -> ShowRegistrationAction
    func makeAction(performBlock: @escaping (()->())) -> Action
}


struct RouterActionsFactory: RouterActionFactoryProtocol {

    func makeShowCountryCodeAction(bloodType: BloodType, performBlock: @escaping (BloodType, CountryCode)->()) -> ShowCountryCodeAction {
        return ShowCountryCodeAction(bloodType: bloodType, performBlock: performBlock)
    }

    func makeShowLocationAction(performBlock: @escaping ((BloodType, CountryCode)->())) -> ShowLocationAction {
        return ShowLocationAction(performBlock: performBlock)
    }

    func makeShowRegistrationAction(bloodType: BloodType, countryCode: String, performBlock: @escaping ((BloodType, LocationModel)->())) -> ShowRegistrationAction {
        return ShowRegistrationAction(bloodType: bloodType, performBlock: performBlock)
    }

    func makeAction(performBlock: @escaping (()->())) -> Action {
        return Action(performBlock: performBlock)
    }
}


class ShowCountryCodeAction {

    private let bloodType: BloodType
    private let performBlock: (BloodType, CountryCode)->()

    init(bloodType: BloodType, performBlock: @escaping ((BloodType, CountryCode)->())) {
        self.bloodType = bloodType
        self.performBlock = performBlock
    }

    func perform(countryCode: CountryCode) {
        performBlock(bloodType, countryCode)
    }
}

class ShowLocationAction {
    
    private let performBlock: ((BloodType, CountryCode)->())
    
    init(performBlock: @escaping ((BloodType, CountryCode)->())) {
        self.performBlock = performBlock
    }
    
    func perform(bloodType: BloodType, countryCode: CountryCode) {
        performBlock(bloodType, countryCode)
    }
}


class ShowRegistrationAction {
    
    private let performBlock: ((BloodType, LocationModel)->())
    private let bloodType: BloodType
    
    init(bloodType: BloodType, performBlock: @escaping ((BloodType, LocationModel)->())) {
        self.bloodType = bloodType
        self.performBlock = performBlock
    }
    
    func perform(location: LocationModel) {
        performBlock(bloodType, location)
    }
}


class Action {
    
    private let performBlock: (()->())
    
    init(performBlock: @escaping (()->())) {
        self.performBlock = performBlock
    }
    
    func perform() {
        performBlock()
    }
}

