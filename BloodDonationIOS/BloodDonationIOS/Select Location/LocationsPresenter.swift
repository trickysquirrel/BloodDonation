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
    let location: LocationModel
    // TODO add country code
}

class LocationsPresenter {
    
    typealias ViewModelsUpdateBlock = ([LocationViewModel], String?) -> ()
    typealias ShowLoadingUpdateBlock = (Bool) -> ()
    private var onEventViewModelsBlock: ViewModelsUpdateBlock?
    private var onEventShowLoadingBlock: ShowLoadingUpdateBlock?
    private let locationFetcher: LocationFetcher
    
    
    init(locationFetcher: LocationFetcher) {
        self.locationFetcher = locationFetcher
    }
    
    
    func onEventNewLocations(block: @escaping ViewModelsUpdateBlock) {
        self.onEventViewModelsBlock = block
    }

    
    func onEventShowLoadingBlock(block: @escaping ShowLoadingUpdateBlock) {
        self.onEventShowLoadingBlock = block
    }
    
    
    func search(string: String) {
        
        guard string.characters.count > 2 else {
            respondWithNotEnoughCharacters()
            return
        }
        
        respondWithSearchStarting()
        
        locationFetcher.search(string: string) { [weak self] response in
            
            self?.respondWithHideLoading()
            
            switch response {
            case .success(let locationModels):
                self?.respondWithViewModels(locationModels: locationModels)
            case .error(let error):
                self?.respondWithError(error:error)
            }
        }
    }
}

// MARK: Responses

extension LocationsPresenter {
    
    private func respondWithHideLoading() {
        self.onEventShowLoadingBlock?(false)
    }
    
    private func respondWithError(error: Error?) {
        self.onEventViewModelsBlock?([], Localisations.localiseError(error))
    }
    
    private func respondWithViewModels(locationModels:[LocationModel]) {
        let viewModels = locationModels.map { LocationViewModel(title:$0.name + " / " + $0.area, location: $0) }
        self.onEventViewModelsBlock?(viewModels, nil)
    }
    
    private func respondWithSearchStarting() {
        self.onEventShowLoadingBlock?(true)
        self.onEventViewModelsBlock?([], Localisations.searching.localised())
    }
    
    private func respondWithNotEnoughCharacters() {
        self.onEventShowLoadingBlock?(false)
        self.onEventViewModelsBlock?([], Localisations.minimumLocationCharSearch.localised())
    }
}
