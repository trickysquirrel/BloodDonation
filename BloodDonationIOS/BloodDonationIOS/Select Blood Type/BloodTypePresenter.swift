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
    
    let bloodTypeSelection: BloodTypeFetcher
    let bloodTypeSetter: BloodTypeSetter
    
    init(bloodTypeSelection: BloodTypeFetcher, bloodTypeSetter: BloodTypeSetter) {
        self.bloodTypeSelection = bloodTypeSelection
        self.bloodTypeSetter = bloodTypeSetter
    }
    
    func updateView() -> [BloodTypeViewModel] {
        let bloodTypeModels = bloodTypeSelection.fetchBloodTypes()
        return bloodTypeModels.map {
            BloodTypeViewModel(title:$0.bloodType.displayString(), highlightColor: highlightColor(bloodTypeModel: $0))
        }
    }
    
    func setBloodType(_ bloodType: BloodType) {
        bloodTypeSetter.set(bloodType: bloodType)
    }
}


extension BloodTypePresenter {
    
    private func highlightColor(bloodTypeModel: BloodTypeModel) -> UIColor {
        if bloodTypeModel.selected {
            return UIColor.bloodTypeFocused
        }
        return UIColor.bloodTypeUnfocused
    }
}
