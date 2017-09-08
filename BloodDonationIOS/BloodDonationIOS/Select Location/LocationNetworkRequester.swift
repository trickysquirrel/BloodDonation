//
//  LocationNetworkRequester.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 8/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

protocol LocationNetworkRequesterProtocol {
    typealias completionBlock = ([[String:Any]]) -> ()
    func search(string: String, completion:completionBlock)
}

class LocationNetworkRequester: LocationNetworkRequesterProtocol {
    
    func search(string: String, completion:completionBlock) {
        completion([["name":"locationName", "state":"VIC"], ["name":"locationName", "state":"NSW"]])
    }

}
