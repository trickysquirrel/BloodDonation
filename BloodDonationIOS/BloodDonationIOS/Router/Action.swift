//
//  RouterActions.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 8/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

protocol ActionProtocol {
    associatedtype V
    func perform(value: V)
}

class Action<V>: ActionProtocol {
    
    private let performBlock: ((V)->())
    
    init(performBlock: @escaping ((V)->())) {
        self.performBlock = performBlock
    }
    
    func perform(value: V) {
        performBlock(value)
    }
}
