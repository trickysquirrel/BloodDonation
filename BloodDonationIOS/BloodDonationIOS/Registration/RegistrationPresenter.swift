//
//  RegistrationPresenter.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 17/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

struct RegistrationViewModel {
    let bloodTypeTitle: String
    let locationTitle: String
}

enum RegistrationResponse {
    case updateView(RegistrationViewModel)
    case registrationSuccess
    case error(String)
}


class RegistrationPresenter {
    
    private let bloodType: BloodType
    private let location: LocationModel
    private let notificationRegister: NotificationRegisterProtocol
    private let messagingSubscriber: MessagingSubscriberProtocol
    private let userStorage: UserPersistentStorageProtocol
    
    
    init(bloodType: BloodType, location: LocationModel, notificationRegister: NotificationRegisterProtocol, messagingSubscriber: MessagingSubscriberProtocol, userStorage: UserPersistentStorageProtocol) {
        self.bloodType = bloodType
        self.location = location
        self.notificationRegister = notificationRegister
        self.messagingSubscriber = messagingSubscriber
        self.userStorage = userStorage
    }
    
    
    func updateView(completion:(RegistrationResponse)->())  {
        let viewModel = RegistrationViewModel(bloodTypeTitle:bloodType.displayString(),
                                              locationTitle: makeAreaNameTitle(location: location))
        completion(.updateView(viewModel))
    }
    
    
    func registerUser(completion:@escaping (RegistrationResponse)->())  {
        
        notificationRegister.register { [weak self] (response) in            
            switch response {
            case .success:
                self?.registerAllTopics()
                self?.persistLocationAndBlood()
                completion(.registrationSuccess)
            case .error(let error):
                completion(.error(Localisations.localiseError(error)))
            }
        }
    }
}

// MARK: Utils

extension RegistrationPresenter {
    
    private func persistLocationAndBlood() {
        userStorage.persistBloodType(bloodType)
        userStorage.persistLocation(location)
    }
    
    private func registerAllTopics() {
        let topicList = MessagingTopicGenerator().allTopics(location: location, blood: bloodType)
        for topic in topicList {
            messagingSubscriber.subscribe(topic: topic)
        }
    }
    
    private func makeAreaNameTitle(location: LocationModel) -> String {
        return location.countryCode.rawValue + ", " + location.area + ", " + location.name
    }
    
}
