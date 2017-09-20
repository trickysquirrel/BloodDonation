//
//  MessagingSubscription.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 17/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation
import FirebaseMessaging


protocol MessagingSubscriberProtocol {
    func subscribe(topic: String)
    func unsubscribe(topic: String)
}

class MessagingSubscriber: MessagingSubscriberProtocol {
    
    func subscribe(topic: String) {
        Messaging.messaging().subscribe(toTopic: topic)
    }
    
    func unsubscribe(topic: String) {
        Messaging.messaging().unsubscribe(fromTopic: topic)
    }
}
