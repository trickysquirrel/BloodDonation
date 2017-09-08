//
//  Throttle.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 8/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation


class Throttle<T> {
    
    private var throttleTimer: Timer?
    
    func value(withDelay delay: TimeInterval, object: T,  response: @escaping (T)->()) {
        throttleTimer?.invalidate()
        throttleTimer = nil
        if #available(iOS 10.0, *) {
            throttleTimer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { (timer) in
                response(object)
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
}
