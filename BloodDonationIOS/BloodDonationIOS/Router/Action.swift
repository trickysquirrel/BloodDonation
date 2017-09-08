//
//  RouterActions.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 8/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

protocol ActionProtocol {
    func perform()
}

class Action: ActionProtocol {
    
    private let performBlock: (()->())
    
    init(performBlock: @escaping (()->())) {
        self.performBlock = performBlock
    }
    
    func perform() {
        performBlock()
    }
}
