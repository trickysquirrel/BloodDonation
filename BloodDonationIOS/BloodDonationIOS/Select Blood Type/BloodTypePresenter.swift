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
    let type: BloodType
}


class BloodTypePresenter {
    
    private let allBloodTypesFetcher: AllBloodTypesFetcher

    typealias UpdateBlock = ([BloodTypeViewModel]) -> ()
    var onEventUpdateBlock: UpdateBlock?
    
    
    init(allBloodTypesFetcher: AllBloodTypesFetcher) {
        self.allBloodTypesFetcher = allBloodTypesFetcher
    }
    
    
    func onEventUpdate(updateBlock: @escaping UpdateBlock) {
        self.onEventUpdateBlock = updateBlock
    }
    
    
    func updateView() {
        let bloodTypes = allBloodTypesFetcher.fetchBloodTypes()
        let viewModels =  bloodTypes.map {
            BloodTypeViewModel(title:$0.displayString(), type: $0)
        }
        onEventUpdateBlock?(viewModels)
    }
    
}

