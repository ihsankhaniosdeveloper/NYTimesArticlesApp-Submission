//
//  NYTimesEndpointTests.swift
//  NYTimesArticlesAppTests
//
//  Created by Ihsan Ullah on 27/08/2024.
//

import XCTest
@testable import NYTimesArticlesApp
class NYTimesEndpointTests: XCTestCase {
    
    func testMostViewedPath() {
        let section = "all-sections"
        let apiKey = "test-api-key"
        let endpoint = NYTimesEndpoint.mostViewed(section: section, period: 7, apiKey: apiKey)
        let expectedPath = "/svc/mostpopular/v2/mostviewed/all-sections/7.json"
        
        let path = endpoint.path
        
        //Assert
        XCTAssertEqual(path, expectedPath)
    }
    
    func testQueryItems() {
        let section = "all-sections"
        let period = 7
        let apiKey = "test-api-key"
        let endpoint = NYTimesEndpoint.mostViewed(section: section, period: period, apiKey: apiKey)
        let expectedQueryItem = NYTimesQueryItem(key: "api-key", value: apiKey)
        
        let queryItems = endpoint.queryItems
        //Assert
        XCTAssertEqual(queryItems?.first?.key, expectedQueryItem.key)
        XCTAssertEqual(queryItems?.first?.value, expectedQueryItem.value)
    }
    
    func testURLRequestCreation() {
        let section = "all-sections"
        let period = 7
        let apiKey = "test-api-key"
        let endpoint = NYTimesEndpoint.mostViewed(section: section, period: period, apiKey: apiKey)
        
        let urlRequest = endpoint.urlRequest()
        //Assert
        XCTAssertNotNil(urlRequest)
        XCTAssertEqual(urlRequest?.httpMethod, "GET")
        XCTAssertTrue(urlRequest?.url?.absoluteString.contains("api.nytimes.com") ?? false)
    }
}
