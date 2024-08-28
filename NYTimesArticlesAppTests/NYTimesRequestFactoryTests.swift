//
//  NYTimesRequestFactoryTests.swift
//  NYTimesArticlesAppTests
//
//  Created by Ihsan Ullah on 27/08/2024.
//

import Foundation
@testable import NYTimesArticlesApp
import XCTest
class NYTimesRequestFactoryTests: XCTestCase {
    
    func testBaseURLComponents() {
        let expectedScheme = "https"
        let expectedHost = "api.nytimes.com"
        let components = NYTimesRequestFactory.baseURLComponents()
        
        //Assert
        XCTAssertEqual(components.scheme, expectedScheme)
        XCTAssertEqual(components.host, expectedHost)
    }
    
    func testBaseURLRequest() {
        let url = URL(string: "https://api.nytimes.com/test")!
        let request = NYTimesRequestFactory.baseURLRequest(url: url)
        //Assert
        XCTAssertEqual(request.url, url)
        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-type"), "application/json")
    }
}
