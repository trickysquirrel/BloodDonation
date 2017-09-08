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
    
    typealias UpdateBlock = ([LocationViewModel]) -> ()
    private var onEventUpdateBlock: UpdateBlock?
    private let locationFetcher: LocationFetcher
    
    
    init(locationFetcher: LocationFetcher) {
        self.locationFetcher = locationFetcher
    }
    
    
    func onSearchResultsEvent(updateBlock: @escaping UpdateBlock) {
        self.onEventUpdateBlock = updateBlock
    }
    
    
    func search(string: String) {
        guard string.characters.count > 2 else {
            self.onEventUpdateBlock?([])
            return
        }
        locationFetcher.search(string: string) { locationModels in
            let viewModels = locationModels.map { LocationViewModel(title:$0.title + " / " + $0.area) }
            self.onEventUpdateBlock?(viewModels)
        }
    }

}
