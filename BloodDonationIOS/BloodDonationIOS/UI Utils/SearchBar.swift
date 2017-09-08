//
//  SearchBar.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 8/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import UIKit

class SearchBar: UISearchBar, UISearchBarDelegate {
    
    typealias StringChangedBlock = (_ text: String) -> ()
    private var stringChangedBlock: StringChangedBlock?
    private let throttle = Throttle<String>()
    
    
    func onEventChanged(stringChanged: @escaping StringChangedBlock) {
        self.stringChangedBlock = stringChanged
        self.delegate = self
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        throttle.value(withDelay: 0.3, object: searchText, response: { [weak self] trottledText in
            self?.stringChangedBlock?(searchText)
        })
    }
    
}
