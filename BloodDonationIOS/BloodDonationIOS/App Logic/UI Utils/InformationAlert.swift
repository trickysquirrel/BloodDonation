//
//  InformationAlert.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 20/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit

class Alert {
    
    func displayErrorAlertTitle(title: String="Error", message: String, presentingViewController: UIViewController?) {
        
        guard let presentingViewController = presentingViewController else { return }
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        presentingViewController.present(alertController, animated: true, completion: nil)
    }
    
}
