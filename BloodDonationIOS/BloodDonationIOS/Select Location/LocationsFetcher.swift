//
//  LocationsFetcher.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 8/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

struct LocationModel {
    let title: String
    let area: String
}

class LocationFetcher {
    
    typealias completionBlock = ([LocationModel]) -> ()
    private let locationNetworkRequester: LocationNetworkRequesterProtocol
    
    init(locationNetworkRequester: LocationNetworkRequesterProtocol) {
        self.locationNetworkRequester = locationNetworkRequester
    }
    
    func search(string: String, completion:completionBlock) {
        locationNetworkRequester.search(string: string) { dictionaryList in
            let viewModels = dictionaryList.flatMap { makeLocationModel(dictionary: $0) }
            completion(viewModels)
        }
    }
    
    private func makeLocationModel(dictionary: [String:Any]) -> LocationModel? {
        guard let title = dictionary["name"] as? String else { return nil }
        guard let area = dictionary["state"] as? String else { return nil }
        return LocationModel(title: title, area: area)
    }
}
