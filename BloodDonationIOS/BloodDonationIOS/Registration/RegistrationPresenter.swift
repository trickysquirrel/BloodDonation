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
    private let notificationRegister: NotificationRegesterProtocol
    private let messagingSubscriber: MessagingSubscriberProtocol
    private let userStorage: UserPersistentStorageProtocol
    
    
    init(bloodType: BloodType, location: LocationModel, notificationRegister: NotificationRegesterProtocol, messagingSubscriber: MessagingSubscriberProtocol, userStorage: UserPersistentStorageProtocol) {
        self.bloodType = bloodType
        self.location = location
        self.notificationRegister = notificationRegister
        self.messagingSubscriber = messagingSubscriber
        self.userStorage = userStorage
    }
    
    
    func updateView(completion:(RegistrationResponse)->())  {
        let viewModel = RegistrationViewModel(bloodTypeTitle:bloodType.displayString(),
                                              locationTitle: makeLocationTitle(location: location))
        completion(.updateView(viewModel))
    }
    
    
    func registerUser(completion:(RegistrationResponse)->())  {
        
        notificationRegister.register { [weak self] (success) in
            
            guard let strongSelf = self else { return }
            
            if success == false {
                completion(.error(Localisations.notificationRegistrationError.localised()))
            }
            else {
                strongSelf.messagingSubscriber.subscribe(topic: makeTopicTitle(location: location, bloodType: bloodType))
                strongSelf.messagingSubscriber.subscribe(topic: "alldevices")
                strongSelf.userStorage.persistBloodType(strongSelf.bloodType)
                strongSelf.userStorage.persistLocation(strongSelf.location)
                completion(.registrationSuccess)
            }
        }
    }
}

// MARK: Utils

extension RegistrationPresenter {
    
    private func makeTopicTitle(location: LocationModel, bloodType: BloodType) -> String {
        let upperCaseString = location.countryCode.rawValue + "/" + location.area + "/" + location.name + "/" + bloodType.displayString()
        return upperCaseString.lowercased()
    }
    
    private func makeLocationTitle(location: LocationModel) -> String {
        return location.countryCode.rawValue + ", " + location.area + ", " + location.name
    }
    
}
