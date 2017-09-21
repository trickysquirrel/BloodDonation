//
//  MessagingSubscription.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 17/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation
import FirebaseMessaging


protocol MessagingTopicSubscriberProtocol {
    func subscribe(topics: [String])
    func unsubscribe(topics: [String])
}

class MessagingTopicSubscriber: MessagingTopicSubscriberProtocol {
    
    func subscribe(topics: [String]) {
        topics.forEach { topic in
            Messaging.messaging().subscribe(toTopic: topic)
        }
    }
    
    func unsubscribe(topics: [String]) {
        topics.forEach { topic in
            Messaging.messaging().unsubscribe(fromTopic: topic)
        }
    }
}
