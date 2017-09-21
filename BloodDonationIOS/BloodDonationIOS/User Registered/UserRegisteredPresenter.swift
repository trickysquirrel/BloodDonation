//
//  UserRegisteredViewControllerPresenter.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 20/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

typealias ErrorString = String

class UserRegisteredPresenter {
    
    private let userRegistered: UserRegistered

    
    init(userRegistered: UserRegistered) {
        self.userRegistered = userRegistered
    }
    
    
    func updateView(completion:(UserDataViewModel)->()) {
        let storedBloodType = userRegistered.fetchBloodType()
        let storedLocation = userRegistered.fetchLocation()
        completion(UserDataViewModel(bloodTypeTitle: storedBloodTypeTitle(bloodType: storedBloodType),
                                     locationTitle: storedLocationTitle(location: storedLocation)))
    }
    
    // TODO: change this to Error
    func resetUser() -> ErrorString? {
        
        let error = userRegistered.unRegister()
        
        switch error {
        case .cannotDetectNetwork:
            return Localisations.unsubscribeCannotDetectNetwork.localised()
        case .isNotConnectedToNetwork:
            return Localisations.unsubscribeNoNetwork.localised()
        case .notAllInformationStored:
            // do nothing
            return nil
        case .none:
            return nil
        }
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

}
