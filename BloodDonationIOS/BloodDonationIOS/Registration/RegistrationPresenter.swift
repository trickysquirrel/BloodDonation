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
                self?.registerForAllTopics()
                self?.persistLocationAndBlood()
                completion(.registrationSuccess)
            case .error(let error):
                completion(.error(Localisations.localiseError(error)))
            }
        }
    }
    
    private func persistLocationAndBlood() {
        self.userStorage.persistBloodType(bloodType)
        self.userStorage.persistLocation(location)
    }
    
    private func registerForAllTopics() {
        self.messagingSubscriber.subscribe(topic: makeAreaNameBloodTopicTitle(location: location, bloodType: bloodType))
        self.messagingSubscriber.subscribe(topic: makeAreaNameTopicTitle(location: location, bloodType: bloodType))
        self.messagingSubscriber.subscribe(topic: makeAreaBloodTopicTitle(location: location, bloodType: bloodType))
        self.messagingSubscriber.subscribe(topic: makeAreaTopicTitle(location: location, bloodType: bloodType))
    }
}

// MARK: Utils

extension RegistrationPresenter {
    
    private func makeAreaNameBloodTopicTitle(location: LocationModel, bloodType: BloodType) -> String {
        let upperCaseString = location.countryCode.rawValue + "/" + location.area + "/" + location.name + "/" + bloodType.displayString()
        return upperCaseString.lowercased()
    }

    private func makeAreaNameTopicTitle(location: LocationModel, bloodType: BloodType) -> String {
        let upperCaseString = location.countryCode.rawValue + "/" + location.area + "/" + location.name
        return upperCaseString.lowercased()
    }

    private func makeAreaBloodTopicTitle(location: LocationModel, bloodType: BloodType) -> String {
        let upperCaseString = location.countryCode.rawValue + "/" + location.area + "/" + bloodType.displayString()
        return upperCaseString.lowercased()
    }

    private func makeAreaTopicTitle(location: LocationModel, bloodType: BloodType) -> String {
        let upperCaseString = location.countryCode.rawValue + "/" + location.area
        return upperCaseString.lowercased()
    }

    private func makeAreaNameTitle(location: LocationModel) -> String {
        return location.countryCode.rawValue + ", " + location.area + ", " + location.name
    }
    
}
