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
    var stubJsonNetworkRequester: StubJsonNetworkRequester!
    
    override func setUp() {
        super.setUp()
        stubJsonNetworkRequester = StubJsonNetworkRequester()
        let locationFetcher = LocationFetcher(jsonRequester: stubJsonNetworkRequester)
        presenter = LocationsPresenter(locationFetcher: locationFetcher)
    }
    
    override func tearDown() {
        stubJsonNetworkRequester = nil
        presenter = nil
        super.tearDown()
    }
    
    private var fakeResponse1Location: [String:Any] = [
        "totalResultsCount": 3,
        "geonames": [
            [
                "name": "Eltham",
                "countryName": "Australia",
                "adminName1": "Victoria",
            ]
        ]
    ]
    
    private var fakeResponse3Location: [String:Any] = [
        "totalResultsCount": 3,
        "geonames": [
            [
                "name": "Eltham",
                "countryName": "Australia",
                "adminName1": "Victoria",
                ],
            [
                "name": "Eltham",
                "countryName": "Australia",
                "adminName1": "New South Wales",
                ],
            [
                "name": "Eltham North",
                "countryName": "Australia",
                "adminName1": "Victoria",
                ]
        ]
    ]

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
        
        stubJsonNetworkRequester.fakeResponse = JsonRequesterResponse.success(fakeResponse1Location)
        
        var eventHandlerCounter: Int = 0
        presenter.onSearchResultsEvent { _ in
            eventHandlerCounter += 1
        }
        presenter.search(string:"abc")
        XCTAssertEqual(eventHandlerCounter, 1)
    }

    
    func test_search_3character_respondsWithViewModels() {
        
        stubJsonNetworkRequester.fakeResponse = JsonRequesterResponse.success(fakeResponse1Location)
        
        var viewModels: [LocationViewModel] = []
        presenter.onSearchResultsEvent { newViewModels in
            viewModels = newViewModels
        }
        presenter.search(string:"abc")
        XCTAssertEqual(viewModels.count, 1)
    }
    

    func test_search_respondsWith3Models_returns3ViewModels() {
        
        stubJsonNetworkRequester.fakeResponse = JsonRequesterResponse.success(fakeResponse3Location)
        
        var viewModels: [LocationViewModel] = []
        presenter.onSearchResultsEvent { newViewModels in
            viewModels = newViewModels
        }
        presenter.search(string:"abc")
        XCTAssertEqual(viewModels.count, 3)
    }
    
    
    func test_search_respondsWithTitleAndStateAsOneString() {
        
        stubJsonNetworkRequester.fakeResponse = JsonRequesterResponse.success(fakeResponse1Location)
        
        var viewModels: [LocationViewModel] = []
        presenter.onSearchResultsEvent { newViewModels in
            viewModels = newViewModels
        }
        presenter.search(string:"abc")
        XCTAssertEqual(viewModels[0].title, "Eltham / Victoria")
    }
    
    
    func test_search_3character_generatedCorrectUrlString() {
        presenter.search(string:"abc")
        XCTAssertEqual(stubJsonNetworkRequester.providedUrlString, "http://api.geonames.org/searchJSON?username=richardmoult&country=AU&featureClass=P&name_startsWith=abc")
    }

    
}
