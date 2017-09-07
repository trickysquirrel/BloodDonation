//
//  BloodTypePresenter.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit

struct BloodTypeViewModel {
    let title: String
    let highlightColor: UIColor
}


class BloodTypePresenter {
    
    let bloodTypeSelection: BloodTypeSelection
    
    init(bloodTypeSelection: BloodTypeSelection) {
        self.bloodTypeSelection = bloodTypeSelection
    }
    
    func updateView() -> [BloodTypeViewModel] {
        let bloodTypeModels = bloodTypeSelection.fetchBloodTypes()
        return bloodTypeModels.map {
            BloodTypeViewModel(title:$0.bloodType.displayString(), highlightColor: highlightColor(bloodTypeModel: $0))
        }
    }
    
    private func highlightColor(bloodTypeModel: BloodTypeModel) -> UIColor {
        if bloodTypeModel.selected {
            return UIColor.bloodTypeFocused
        }
        return UIColor.bloodTypeUnfocused
    }
}
