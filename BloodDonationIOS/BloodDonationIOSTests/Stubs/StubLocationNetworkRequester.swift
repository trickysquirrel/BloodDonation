//
//  StubLocationNetworkRequester.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 8/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation
@testable import BloodDonationIOS

class StubLocationNetworkRequester: LocationNetworkRequesterProtocol {
    
    public var fakeResponse: [[String: Any]] = []
    
    func search(string: String, completion:completionBlock) {
        completion(fakeResponse)
    }
    
}
