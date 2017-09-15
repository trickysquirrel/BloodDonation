//
//  LoadingIndicator.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 9/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit


protocol LoadingIndicatorProtocol {
    func show(_ show: Bool)
}


struct LoadingIndicator: LoadingIndicatorProtocol {
    
    func show(_ show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
}
