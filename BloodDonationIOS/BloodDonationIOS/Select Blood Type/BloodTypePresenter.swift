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
    let type: BloodType
}


class BloodTypePresenter {
    
    let bloodTypeSelection: BloodTypeFetcher
    let bloodTypeSetter: BloodTypeSetter

    typealias UpdateBlock = ([BloodTypeViewModel]) -> ()
    var onEventUpdateBlock: UpdateBlock?
    
    
    init(bloodTypeSelection: BloodTypeFetcher, bloodTypeSetter: BloodTypeSetter) {
        self.bloodTypeSelection = bloodTypeSelection
        self.bloodTypeSetter = bloodTypeSetter
    }
    
    
    func onEventUpdate(updateBlock: @escaping UpdateBlock) {
        self.onEventUpdateBlock = updateBlock
    }
    
    
    func updateView() {
        let bloodTypeModels = bloodTypeSelection.fetchBloodTypes()
        let viewModels =  bloodTypeModels.map {
            BloodTypeViewModel(title:$0.bloodType.displayString(),
                               highlightColor: highlightColor(bloodTypeModel: $0),
                               type: $0.bloodType)
        }
        onEventUpdateBlock?(viewModels)
    }
    
    
    func updateBloodType(_ bloodType: BloodType) {
        bloodTypeSetter.set(bloodType: bloodType)
        updateView()
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
