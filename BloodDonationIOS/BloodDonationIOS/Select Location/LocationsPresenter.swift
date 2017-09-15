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
        
        self.onEventViewModelsBlock?([], Localisations.searching.localised())
        
        locationFetcher.search(string: string) { [weak self] response in
            
            switch response {
            case .success(let locationModels):
                let viewModels = locationModels.map { LocationViewModel(title:$0.title + " / " + $0.area) }
                self?.onEventViewModelsBlock?(viewModels, nil)
            case .error(let error):
                self?.onEventViewModelsBlock?([], self?.stringError(error))
            }
        }
    }
    
    
    private func stringError(_ error: Error?) -> String {
        print("error ===== \(String(describing: error))")
        print("error ===== \(String(describing: error?.localizedDescription))")
        guard (error?.localizedDescription != "unknown") else {
            return Localisations.unknownError.localised()
        }
        guard let error = error else {
            return Localisations.unknownError.localised()
        }
        return error.localizedDescription
    }

}
