//
//  StubMessagingSubscription.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 17/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation
@testable import BloodDonationIOS


class StubMessagingSubscriber: MessagingSubscriberProtocol {
    
    private(set) var providedTopic: String = ""
    
    func subscribe(topic: String) {
        providedTopic = topic
    }
}
