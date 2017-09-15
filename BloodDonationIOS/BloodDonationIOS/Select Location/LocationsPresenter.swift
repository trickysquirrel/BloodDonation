//
//  LocationsPresenter.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 8/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

struct LocationViewModel {
    let title: String
}

class LocationsPresenter {
    
    typealias ViewModelsUpdateBlock = ([LocationViewModel], String?) -> ()
    private var onEventViewModelsBlock: ViewModelsUpdateBlock?
    private let locationFetcher: LocationFetcher
    
    
    init(locationFetcher: LocationFetcher) {
        self.locationFetcher = locationFetcher
    }
    
    
    func onEventNewLocations(updateBlock: @escaping ViewModelsUpdateBlock) {
        self.onEventViewModelsBlock = updateBlock
    }

    
    func search(string: String) {
        
        guard string.characters.count > 2 else {
            self.onEventViewModelsBlock?([], Localisations.minimumLocationCharSearch.localised())
            return
        }
        
        self.onEventViewModelsBlock?([], "Searching")
        locationFetcher.search(string: string) { locationModels in
            let viewModels = locationModels.map { LocationViewModel(title:$0.title + " / " + $0.area) }
            self.onEventViewModelsBlock?(viewModels, nil)
        }
    }

}
