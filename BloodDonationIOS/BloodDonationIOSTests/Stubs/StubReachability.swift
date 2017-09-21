//
//  StubReachabilityProtocol.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 21/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation
@testable import BloodDonationIOS


class StubReachability: ReachabilityProtocol {
    
    public var isConnected = true
    
    func isNetworkConnectionReachable() -> Bool {
        return isConnected
    }
}
