//
//  MessagingSubscription.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 17/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

protocol MessagingSubscriberProtocol {
    func subscribe(topic: String)
}

class MessagingSubscriber: MessagingSubscriberProtocol {
    
    func subscribe(topic: String) {
    }
}
