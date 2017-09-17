//
//  StubNotificationRegester.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 17/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation
@testable import BloodDonationIOS


class StubNotificationRegister: NotificationRegesterProtocol {
    
    public var success: Bool = false
    
    func register(completion:(Bool)->()) {
        completion(success)
    }
    
}
