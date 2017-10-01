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
	let informationText: String
}

enum RegistrationResponse {
    case updateView(UserDataViewModel)
    case registrationSuccess
    case error(String)
}


class RegistrationPresenter {
    
    private let notificationRegister: MessagingRegisterProtocol
    private let messagingSubscriber: MessagingTopicSubscriberProtocol
    private let registerUser: RegisterUser
    
    
    init(notificationRegister: MessagingRegisterProtocol, messagingSubscriber: MessagingTopicSubscriberProtocol, registerUser: RegisterUser) {
        self.notificationRegister = notificationRegister
        self.messagingSubscriber = messagingSubscriber
        self.registerUser = registerUser
    }
    
    
    func updateView(completion:(RegistrationResponse)->())  {
        let viewModel = UserDataViewModel(bloodTypeTitle:registerUser.bloodType.displayString(),
                                          locationTitle: makeAreaNameTitle(location: registerUser.location),
                                          informationText: Localisations.subscribeInfo.localised())
        completion(.updateView(viewModel))
    }
    
    
    func registerUser(completion:@escaping (RegistrationResponse)->())  {

        registerUser.register { error in
            switch error {
            case .cannotDetectNetwork:
                return completion(.error(Localisations.unsubscribeCannotDetectNetwork.localised()))
            case .isNotConnectedToNetwork:
                return completion(.error(Localisations.unsubscribeNoNetwork.localised()))
            case .notificationError(let error):
                completion(.error(Localisations.localiseError(error)))
            case .none:
                completion(.registrationSuccess)
            }
        }
    }
}

// MARK: Utils

extension RegistrationPresenter {
        
    private func makeAreaNameTitle(location: LocationModel) -> String {
        return location.countryCode.rawValue + ", " + location.area + ", " + location.name
    }
    
}
