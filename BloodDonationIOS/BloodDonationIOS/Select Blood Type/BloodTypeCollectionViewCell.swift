//
//  BloodTypeCollectionViewCell.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit

class BloodTypeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    
    func configure(viewModel: BloodTypeViewModel) {
        label.text = viewModel.title
        label.backgroundColor = viewModel.highlightColor
    }
}
