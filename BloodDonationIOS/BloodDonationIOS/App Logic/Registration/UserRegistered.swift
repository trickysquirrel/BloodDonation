//
//  BloodPersisted.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 20/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation


enum UserUnRegistationError: Error {
    case cannotDetectNetwork
    case isNotConnectedToNetwork
    case notAllInformationStored
    case none
}


struct UserRegistered {
    
    let userStorage: UserPersistentStorageProtocol
    let messagingTopicManager: MessagingTopicManager

    
    func hasUserAlreadyRegistered() -> Bool {
        return userStorage.hasPersistedData()
    }

    
    func fetchBloodType() -> BloodType? {
        return userStorage.fetchBloodType()
    }
    
    
    func fetchLocation() -> LocationModel? {
        return userStorage.fetchLocation()
    }
    
    
    func unRegister() -> UserUnRegistationError {
        
        guard   let storedBloodType = self.fetchBloodType(),
                let storedLocation = self.fetchLocation() else {
                userStorage.deleteAllData()
                return .notAllInformationStored
        }
        
        let topics = MessagingTopicGenerator().allTopics(location: storedLocation, blood: storedBloodType)
        
        let error = messagingTopicManager.unsubscribe(topics: topics)

        switch error {
        case .cannotDetectForReachability:
            return .cannotDetectNetwork
        case .notConnectedToNetwork:
            return .isNotConnectedToNetwork
        case .none:
            userStorage.deleteAllData()
        }
        
        return .none
    }

}
