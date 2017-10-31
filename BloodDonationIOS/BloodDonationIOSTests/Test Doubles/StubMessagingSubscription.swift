//
//  StubMessagingSubscription.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 17/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation
@testable import BloodDonationIOS


class StubMessagingSubscriber: MessagingTopicSubscriberProtocol {
    
    private(set) var providedTopic: [String] = []
    private(set) var unsubscribeTopic: [String] = []

    func subscribe(topics: [String]) {
        providedTopic.append(contentsOf: topics)
    }
    
    func unsubscribe(topics: [String]) {
        unsubscribeTopic.append(contentsOf: topics)
    }
}
