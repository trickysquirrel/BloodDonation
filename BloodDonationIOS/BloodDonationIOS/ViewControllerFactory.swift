//
//  ViewControllerFactory.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit

struct ViewControllerFactory {
    
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    func bloodTypeSelector() -> BloodTypeCollectionViewController {
        return storyboard.instantiateViewController(withIdentifier: "BloodTypeCollectionViewControllerId") as! BloodTypeCollectionViewController
    }
}
