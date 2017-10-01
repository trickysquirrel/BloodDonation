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
    
    private var fakeResponseError: Error = NSError(domain: "domain", code: 0, userInfo: [NSLocalizedDescriptionKey:"error string"])

    private var fakeResponseErrorUnknown: Error = NSError(domain: "domain", code: 0, userInfo: [NSLocalizedDescriptionKey:"unknown"])

    
    private var fakeResponse0Location: [String:Any] = [
        "totalResultsCount": 3,
        "geonames": []
    ]

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

// MARK:- onEventNewLocations

extension LocationsPresenterTests {
    
    func test_search_1character_respondsOnce() {
        var eventHandlerCounter: Int = 0
        presenter.onEventNewLocations { _, _ in 
            eventHandlerCounter += 1
        }
        presenter.search(string:"a")
        XCTAssertEqual(eventHandlerCounter, 1)
    }

    
    func test_search_1character_respondsWithEmptyViewModel() {
        var viewModels: [LocationViewModel] = []
        presenter.onEventNewLocations { newViewModels, information in
            viewModels = newViewModels
        }
        presenter.search(string:"a")
        XCTAssertEqual(viewModels.count, 0)
    }

    
    func test_search_1character_respondsWithUserInformation() {
        var userInformation: String?
        presenter.onEventNewLocations { newViewModels, information in
            userInformation = information
        }
        presenter.search(string:"a")
        XCTAssertEqual(userInformation, "minimum 3 characters")
    }

    
    func test_search_3character_respondsTwice() {
        
        stubJsonNetworkRequester.fakeResponse = JsonRequesterResponse.success(fakeResponse1Location)
        
        var eventHandlerCounter: Int = 0
        presenter.onEventNewLocations { _,_ in
            eventHandlerCounter += 1
        }
        presenter.search(string:"abc")
        XCTAssertEqual(eventHandlerCounter, 2)
    }
    
    
    func test_search_3character_respondsFirstWithUserInformationSearching() {
        
        stubJsonNetworkRequester.fakeResponse = JsonRequesterResponse.success(fakeResponse1Location)
        var responseCount: Int = 0
        var userInformation: String?
        var viewModels: [LocationViewModel] = []
        presenter.onEventNewLocations { newViewModels, information in
            if responseCount == 0 {
                viewModels = newViewModels
                userInformation = information
            }
            responseCount += 1
        }
        presenter.search(string:"abc")
        XCTAssertEqual(viewModels.count, 0)
        XCTAssertEqual(userInformation, "searching...")
    }


    
    func test_search_3character_respondsSecondWithViewModels() {
        
        stubJsonNetworkRequester.fakeResponse = JsonRequesterResponse.success(fakeResponse1Location)
        
        var responseCount: Int = 0
        var userInformation: String? = ""
        var viewModels: [LocationViewModel] = []
        presenter.onEventNewLocations { newViewModels, information in
            if responseCount == 1 {
                viewModels = newViewModels
                userInformation = information
            }
            responseCount += 1
        }
        presenter.search(string:"abc")
        XCTAssertEqual(viewModels.count, 1)
        XCTAssertNil(userInformation)
    }

    
    func test_search_3character_respondsWithNilUserInformation() {
        
        stubJsonNetworkRequester.fakeResponse = JsonRequesterResponse.success(fakeResponse1Location)
        
        var userInformation: String? = ""
        presenter.onEventNewLocations { newViewModels, information in
            userInformation = information
        }
        presenter.search(string:"abc")
        XCTAssertNil(userInformation)
    }


    func test_search_respondsWith3Models_returns3ViewModelsWithCorrectLocationModelValues() {
        
        stubJsonNetworkRequester.fakeResponse = JsonRequesterResponse.success(fakeResponse3Location)
        
        var viewModels: [LocationViewModel] = []
        presenter.onEventNewLocations { newViewModels, information in
            viewModels = newViewModels
        }
        
        presenter.search(string:"abc")
        
        XCTAssertEqual(viewModels[0].location.name, "Eltham")
        XCTAssertEqual(viewModels[0].location.area, "Victoria")
    }

    
    func test_search_respondsWith3Models_returns3ViewModelsWithCorrectTitle() {
        
        stubJsonNetworkRequester.fakeResponse = JsonRequesterResponse.success(fakeResponse3Location)
        
        var viewModels: [LocationViewModel] = []
        presenter.onEventNewLocations { newViewModels, information in
            viewModels = newViewModels
        }
        
        presenter.search(string:"abc")
        
        XCTAssertEqual(viewModels.count, 3)
        XCTAssertEqual(viewModels[0].title, "Eltham / Victoria")
        XCTAssertEqual(viewModels[1].title, "Eltham / New South Wales")
        XCTAssertEqual(viewModels[2].title, "Eltham North / Victoria")
    }

    
    func test_search_3character_generatedCorrectUrlString() {
        presenter.search(string:"abc def")
        XCTAssertEqual(stubJsonNetworkRequester.providedUrlString, "http://api.geonames.org/searchJSON?username=richardmoult&country=AU&featureClass=P&name_startsWith=abc%20def")
    }

    
    func test_search_networkError_returnLocalisedDescription() {
        stubJsonNetworkRequester.fakeResponse = JsonRequesterResponse.error(fakeResponseError)
        var userInformation: String? = ""
        presenter.onEventNewLocations { newViewModels, information in
            userInformation = information
        }
        presenter.search(string:"abc")
        XCTAssertEqual(userInformation, "error string")
    }

    
    func test_search_networkErrorNil_returnUnknownLocalisedDescription() {
        stubJsonNetworkRequester.fakeResponse = JsonRequesterResponse.error(fakeResponseErrorUnknown)
        var userInformation: String? = ""
        presenter.onEventNewLocations { newViewModels, information in
            userInformation = information
        }
        presenter.search(string:"abc")
        XCTAssertEqual(userInformation, "unknown error please try again")
    }
    
    func test_search_noResults_respondsWithZeroViewModelsUserInformationTryAgain() {
        
        stubJsonNetworkRequester.fakeResponse = JsonRequesterResponse.success(fakeResponse0Location)
        
        var responseCount: Int = 0
        var userInformation: String? = ""
        var viewModels: [LocationViewModel] = []
        presenter.onEventNewLocations { newViewModels, information in
            if responseCount == 1 {
                viewModels = newViewModels
                userInformation = information
            }
            responseCount += 1
        }
        presenter.search(string:"abc")
        XCTAssertEqual(viewModels.count, 0)
        XCTAssertEqual(userInformation, "Location not found please try again")
    }


}

// MARK:- search

extension LocationsPresenterTests {
    
    func test_search_1character_setsLoadingToFalse() {
        var showLoading: Bool?
        presenter.onEventShowLoadingBlock { show in
            showLoading = show
        }
        presenter.search(string:"a")
        XCTAssertFalse(showLoading!)
    }

    
    func test_search_3character_setsLoadingToTrueFirst() {
        var blockCounter = 0
        var showLoading: Bool?
        presenter.onEventShowLoadingBlock { show in
            if blockCounter == 0 {
                showLoading = show
            }
            blockCounter += 1
        }
        presenter.search(string:"abc")
        XCTAssertTrue(showLoading!)
    }

    func test_search_successLocationResponse_setsLoadingToFalse() {
        stubJsonNetworkRequester.fakeResponse = JsonRequesterResponse.success(fakeResponse3Location)
        
        var blockCounter = 0
        var showLoading: Bool?
        presenter.onEventShowLoadingBlock { show in
            if blockCounter == 1 {
                showLoading = show
            }
            blockCounter += 1
        }
        presenter.search(string:"abc")
        XCTAssertFalse(showLoading!)
    }

    
    func test_search_errorLocationResponse_setsLoadingToFalse() {
        stubJsonNetworkRequester.fakeResponse = JsonRequesterResponse.error(fakeResponseError)
        
        var blockCounter = 0
        var showLoading: Bool?
        presenter.onEventShowLoadingBlock { show in
            if blockCounter == 1 {
                showLoading = show
            }
            blockCounter += 1
        }
        presenter.search(string:"abc")
        XCTAssertFalse(showLoading!)
    }

    
    func test_search_performTwoSearches_requestToCancelsTheRequestTwice() {
        presenter.search(string:"abc")
        presenter.search(string:"abcd")
        XCTAssertEqual(stubJsonNetworkRequester.didCancelCounter, 2)
    }

	func test_search_performTwoSearchesSecondNotValid__requestToCancelsTheRequestTwice() {
		presenter.search(string:"abc")
		presenter.search(string:"")
		XCTAssertEqual(stubJsonNetworkRequester.didCancelCounter, 2)
	}

}

// MARK:- onEventShowLoading

extension LocationsPresenterTests {
    
    func test_cancelSearchingForLocations_requestsToCancelNetworkRequest() {
        presenter.cancelSearchingForLocations()
        XCTAssertEqual(stubJsonNetworkRequester.didCancelCounter, 1)
    }
    
}
