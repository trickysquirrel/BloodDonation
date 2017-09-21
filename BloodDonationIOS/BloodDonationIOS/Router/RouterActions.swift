//
//  RouterActions.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 8/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation


class ShowLocationAction {
    
    private let performBlock: ((BloodType)->())
    
    init(performBlock: @escaping ((BloodType)->())) {
        self.performBlock = performBlock
    }
    
    func perform(bloodType: BloodType) {
        performBlock(bloodType)
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

