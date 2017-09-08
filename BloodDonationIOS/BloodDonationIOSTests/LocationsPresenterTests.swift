//
//  LocationsPresenterTests.swift
//  BloodDonationIOSTests
//
//  Created by Richard Moult on 8/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import XCTest
@testable import BloodDonationIOS

class LocationsPresenterTests: XCTestCase {
    
    var presenter: LocationsPresenter!
    var stubLocationNetworkRequester: StubLocationNetworkRequester!
    
    override func setUp() {
        super.setUp()
        stubLocationNetworkRequester = StubLocationNetworkRequester()
        let locationFetcher = LocationFetcher(locationNetworkRequester: stubLocationNetworkRequester)
        presenter = LocationsPresenter(locationFetcher: locationFetcher)
    }
    
    override func tearDown() {
        stubLocationNetworkRequester = nil
        presenter = nil
        super.tearDown()
    }
}


extension LocationsPresenterTests {
    
    func test_search_1character_respondsOnce() {
        var eventHandlerCounter: Int = 0
        presenter.onSearchResultsEvent { _ in
            eventHandlerCounter += 1
        }
        presenter.search(string:"a")
        XCTAssertEqual(eventHandlerCounter, 1)
    }

    
    func test_search_1character_respondsWithEmptyViewModels() {
        var viewModels: [LocationViewModel] = []
        presenter.onSearchResultsEvent { newViewModels in
            viewModels = newViewModels
        }
        presenter.search(string:"a")
        XCTAssertEqual(viewModels.count, 0)
    }
    
    
    func test_search_3character_respondsOnce() {
        var eventHandlerCounter: Int = 0
        presenter.onSearchResultsEvent { _ in
            eventHandlerCounter += 1
        }
        presenter.search(string:"abc")
        XCTAssertEqual(eventHandlerCounter, 1)
    }

    
    func test_search_3character_respondsWithViewModels() {
        
        stubLocationNetworkRequester.fakeResponse = [["name":"locationName", "state":"VIC"]]
        
        var viewModels: [LocationViewModel] = []
        presenter.onSearchResultsEvent { newViewModels in
            viewModels = newViewModels
        }
        presenter.search(string:"abc")
        XCTAssertEqual(viewModels.count, 1)
    }
    

    func test_search_respondsWith3Models_returns3ViewModels() {
        
        stubLocationNetworkRequester.fakeResponse = [["name":"locationName", "state":"VIC"],["name":"locationName", "state":"VIC"],["name":"locationName", "state":"VIC"]]
        
        var viewModels: [LocationViewModel] = []
        presenter.onSearchResultsEvent { newViewModels in
            viewModels = newViewModels
        }
        presenter.search(string:"abc")
        XCTAssertEqual(viewModels.count, 3)
    }
    
    
    func test_search_respondsWithTitleAndStateAsOneString() {
        
        stubLocationNetworkRequester.fakeResponse = [["name":"locationName", "state":"VIC"]]
        
        var viewModels: [LocationViewModel] = []
        presenter.onSearchResultsEvent { newViewModels in
            viewModels = newViewModels
        }
        presenter.search(string:"abc")
        XCTAssertEqual(viewModels[0].title, "locationName / VIC")
    }
    
}
