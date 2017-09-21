//
//  AreYouSureAlert.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 21/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit

class AreYouSureAlert {
    
    func displayAlertTitle(title: String="Warning",
                           message: String,
                           presentingViewController: UIViewController?,
                           continueActionSelected: @escaping ()-> ()) {
        
        guard let presentingViewController = presentingViewController else { return }
        
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: Localisations.alertOk.localised(), style: UIAlertActionStyle.default) { (action) in
            continueActionSelected()
        }
        
        let cancelAction = UIAlertAction(title: Localisations.alertCancel.localised(), style: UIAlertActionStyle.default, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        presentingViewController.present(alertController, animated: true, completion: nil)
    }
    
}
