//
//  StubNotificationRegester.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 17/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation
@testable import BloodDonationIOS


class StubMessagingRegister: MessagingRegisterProtocol {
    
    public var response: NotificationRegisterResponse?
    
    func register(completion:@escaping (NotificationRegisterResponse)->()) {
        if let response = response {
            completion(response)
        }
    }
    
}
