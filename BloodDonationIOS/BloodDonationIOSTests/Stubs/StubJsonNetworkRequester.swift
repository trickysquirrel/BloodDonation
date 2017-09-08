//
//  StubJsonNetworkRequester.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 8/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation
@testable import BloodDonationIOS

class StubJsonNetworkRequester: JsonRequester {
    
    public var fakeResponse: JsonRequesterResponse?
    private(set) var providedUrlString: String?
    
    func request(urlString: String, completion:@escaping (JsonRequesterResponse)->()) {
        providedUrlString = urlString
        if let fakeResponse = self.fakeResponse {
            completion(fakeResponse)
        }
    }
    
}
