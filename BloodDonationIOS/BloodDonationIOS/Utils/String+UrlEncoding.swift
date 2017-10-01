//
//  String+UrlEncoding.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 15/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

extension String {
    func stringByAddingPercentEncodingForRFC3986() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}
