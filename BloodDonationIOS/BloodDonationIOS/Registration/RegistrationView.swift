//
//  RegistrationView.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 17/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit

class RegistrationView: UIView {

    @IBOutlet weak var labelBloodType: UILabel!
    @IBOutlet weak var labelLocation: UILabel!

    func configure(viewModel: UserDataViewModel) {
        labelBloodType.text = viewModel.bloodTypeTitle
        labelLocation.text = viewModel.locationTitle
    }
}
