//
//  RegistrationPresenter.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 17/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

struct UserDataViewModel {
    let bloodTypeTitle: String
    let locationTitle: String
}

enum RegistrationResponse {
    case updateView(UserDataViewModel)
    case registrationSuccess
    case error(String)
}


class RegistrationPresenter {
    
    private let bloodType: BloodType
    private let location: LocationModel
    private let notificationRegister: NotificationRegisterProtocol
    private let messagingSubscriber: MessagingTopicSubscriberProtocol
    private let registerUser: RegisterUser
    
    
    init(bloodType: BloodType, location: LocationModel, notificationRegister: NotificationRegisterProtocol, messagingSubscriber: MessagingTopicSubscriberProtocol, registerUser: RegisterUser) {
        self.bloodType = bloodType
        self.location = location
        self.notificationRegister = notificationRegister
        self.messagingSubscriber = messagingSubscriber
        self.registerUser = registerUser
    }
    
    
    func updateView(completion:(RegistrationResponse)->())  {
        let viewModel = UserDataViewModel(bloodTypeTitle:bloodType.displayString(),
                                          locationTitle: makeAreaNameTitle(location: location))
        completion(.updateView(viewModel))
    }
    
    
    func registerUser(completion:@escaping (RegistrationResponse)->())  {
        
        notificationRegister.register { [weak self] (response) in            
            switch response {
            case .success:
                self?.registerAllTopics()
                self?.registerAllUserInfo()
                completion(.registrationSuccess)
            case .error(let error):
                completion(.error(Localisations.localiseError(error)))
            }
        }
    }
}

// MARK: Utils

extension RegistrationPresenter {
    
    private func registerAllUserInfo() {
        registerUser.register(location: location, bloodType: bloodType)
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
