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
//    case success
    case error(String)
}


class RegistrationPresenter {
    
    private let bloodType: BloodType
    private let location: LocationModel
    private let notificationRegister: NotificationRegesterProtocol
    private let messagingSubscriber: MessagingSubscriberProtocol
    
    
    init(bloodType: BloodType, location: LocationModel, notificationRegister: NotificationRegesterProtocol, messagingSubscriber: MessagingSubscriberProtocol) {
        self.bloodType = bloodType
        self.location = location
        self.notificationRegister = notificationRegister
        self.messagingSubscriber = messagingSubscriber
    }
    
    
    func updateView(completion:(RegistrationResponse)->())  {
        let viewModel = RegistrationViewModel(bloodTypeTitle:bloodType.displayString(),
                                              locationTitle: makeLocationTitle(location: location))
        completion(.updateView(viewModel))
    }
    
    
    func registerUser(completion:(RegistrationResponse)->())  {
        notificationRegister.register { [weak self] (success) in
            if success == false {
                completion(.error(Localisations.notificationRegistrationError.localised()))
            }
            else {
                self?.messagingSubscriber.subscribe(topic: makeTopicTitle(location: location, bloodType: bloodType))
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
