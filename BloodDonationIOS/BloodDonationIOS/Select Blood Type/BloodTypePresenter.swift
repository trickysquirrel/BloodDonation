//
//  BloodTypePresenter.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

struct BloodTypeViewModel {
    let title: String
}


class BloodTypePresenter {
    
    let bloodTypeSelection: BloodTypeSelection
    
    init(bloodTypeSelection: BloodTypeSelection) {
        self.bloodTypeSelection = bloodTypeSelection
    }
    
    func updateView() -> [BloodTypeViewModel] {
        let bloodTypeModels = bloodTypeSelection.fetchBloodTypes()
        return bloodTypeModels.map { BloodTypeViewModel(title:$0.bloodType.displayString()) }
    }
}
