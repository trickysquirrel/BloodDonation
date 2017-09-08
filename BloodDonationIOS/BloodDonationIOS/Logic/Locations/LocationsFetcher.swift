//
//  LocationsFetcher.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 8/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

struct LocationModel {
    let title: String
    let area: String
}

class LocationFetcher {
    
    typealias completionBlock = ([LocationModel]) -> ()
    private let jsonRequester: JsonRequester
    
    init(jsonRequester: JsonRequester) {
        self.jsonRequester = jsonRequester
    }
    
    func search(string: String, completion:@escaping completionBlock) {
        jsonRequester.request(urlString: makeSearchURLString(string:string)) { [weak self] response in
            switch response {
            case .success(let dictionary):
                let geoNames = self?.extractGeoNames(dictionary: dictionary) ?? [[:]]
                let models = geoNames.flatMap { self?.makeLocationModel(dictionary: $0) }
                completion(models)
            case .error:
                print("error")
            }
        }
    }
    
    private func makeSearchURLString(string: String) -> String {
        return String(format: "http://api.geonames.org/searchJSON?username=richardmoult&country=AU&featureClass=P&name_startsWith=%@", string)
    }
    
    private func extractGeoNames(dictionary: [String:Any]) -> [[String:Any]]? {
        guard let geoNames = dictionary["geonames"] as? [[String:Any]] else { return nil }
        return geoNames
    }
    
    private func makeLocationModel(dictionary: [String:Any]) -> LocationModel? {
        guard let title = dictionary["name"] as? String else { return nil }
        guard let area = dictionary["adminName1"] as? String else { return nil }
        return LocationModel(title: title, area: area)
    }
}
