//
//  RegisterUser.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 20/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation


enum RegisterUserError: Error {
    case cannotDetectNetwork
    case isNotConnectedToNetwork
    case notificationError(Error?)
    case none
}


class RegisterUser {
    
    let userStorage: UserPersistentStorageProtocol
    let messagingTopicManager: MessagingTopicManager
    let notificationRegister: MessagingRegisterProtocol
    let bloodType: BloodType
    let location: LocationModel
    
    init(userStorage: UserPersistentStorageProtocol,
         messagingTopicManager: MessagingTopicManager,
         notificationRegister: MessagingRegisterProtocol,
         bloodType: BloodType,
         location: LocationModel) {
        self.userStorage = userStorage
        self.messagingTopicManager = messagingTopicManager
        self.notificationRegister = notificationRegister
        self.bloodType = bloodType
        self.location = location
    }
    
    
    func register(completion:@escaping (RegisterUserError)->()) {
        
        notificationRegister.register { [weak self] (response) in
            
            switch response {
                
            case .success:
                
                if let error = self?.registerAllTopics() {
                    switch error {
                    case .none:
                        self?.persistAllData()
                        completion(error)
                    default:
                        completion(error)
                    }
                }
            case .error(let error):
                completion(.notificationError(error))
                break
            }
        }
    }
}

// MARK:- Utils

extension RegisterUser {
    
    private func persistAllData() {
        userStorage.persistBloodType(bloodType)
        userStorage.persistLocation(location)
    }
    
    private func registerAllTopics() -> RegisterUserError {
        let topics = MessagingTopicGenerator().allTopics(location: location, blood: bloodType)
        let error = messagingTopicManager.subscribe(topics: topics)
        switch error {
        case .cannotDetectForReachability:
            return .cannotDetectNetwork
        case .notConnectedToNetwork:
            return .isNotConnectedToNetwork
        case .none:
            return .none
        }
    }
    
}
