//
//  MessagingTopicManager.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 21/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

enum MessagingTopicManagerError: Error {
    case cannotDetectForReachability
    case notConnectedToNetwork
    case none
}


struct MessagingTopicManager {
    
    let reachability: ReachabilityProtocol?
    let messagingTopicSubscriber: MessagingTopicSubscriberProtocol

    
    func subscribe(topics: [String]) -> MessagingTopicManagerError {
        
        guard let reachability = reachability else {
            return .cannotDetectForReachability
        }
        
        guard (reachability.isNetworkConnectionReachable() ==  true) else {
            return .notConnectedToNetwork
        }

        messagingTopicSubscriber.subscribe(topics: topics)
        return .none
    }
    
    
    func unsubscribe(topics: [String]) -> MessagingTopicManagerError {
        
        guard let reachability = reachability else {
            return .cannotDetectForReachability
        }
        
        guard (reachability.isNetworkConnectionReachable() ==  true) else {
            return .notConnectedToNetwork
        }

        messagingTopicSubscriber.unsubscribe(topics: topics)
        return .none
    }

}
