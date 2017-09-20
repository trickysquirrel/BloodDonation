//
//  UserRegisteredViewControllerPresenter.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 20/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation


struct UserRegisteredViewModel {
    let bloodTypeTitle: String
    let locationTitle: String
}


class UserRegisteredPresenter {
    
    private let userStorage: UserPersistentStorageProtocol
    private let messagingSubscriber: MessagingSubscriberProtocol

    
    init(userStorage: UserPersistentStorageProtocol, messagingSubscriber: MessagingSubscriberProtocol) {
        self.userStorage = userStorage
        self.messagingSubscriber = messagingSubscriber
    }
    
    func updateView(completion:(UserRegisteredViewModel)->()) {
        let storedBloodType = userStorage.fetchBloodType()
        let storedLocation = userStorage.fetchLocation()
        completion(UserRegisteredViewModel(bloodTypeTitle: storedBloodTypeTitle(bloodType: storedBloodType),
                                           locationTitle: storedLocationTitle(location: storedLocation)))
    }
    
    func resetUser() {
        guard   let storedBloodType = userStorage.fetchBloodType(),
                let storedLocation = userStorage.fetchLocation() else {
            return
        }
        unsubscribeToAllTopics(location: storedLocation, bloodType: storedBloodType)
        //userStorage.persistBloodType(storedBloodType)
        //userStorage.persistLocation(storedLocation)

    }
}

// MARK: Utils

private extension UserRegisteredPresenter {
    
    func storedBloodTypeTitle(bloodType: BloodType?) -> String {
        guard let bloodType = bloodType else {
            return Localisations.unknownBloodType.localised()
        }
        return bloodType.displayString()
    }

    
    func storedLocationTitle(location: LocationModel?) -> String {
        guard let location = location else {
            return Localisations.unknownLocation.localised()
        }
        return makeAreaNameTitle(location: location)
    }
    
    
    func makeAreaNameTitle(location: LocationModel) -> String {
        return location.countryCode.rawValue + ", " + location.area + ", " + location.name
    }

    private func unsubscribeToAllTopics(location: LocationModel, bloodType: BloodType) {
        let topicList = MessagingTopicGenerator().allTopics(location: location, blood: bloodType)
        for topic in topicList {
            messagingSubscriber.unsubscribe(topic: topic)
        }
    }

}
